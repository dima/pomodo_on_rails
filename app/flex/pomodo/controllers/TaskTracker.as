package pomodo.controllers {
  import flash.events.EventDispatcher;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  
  import pomodo.events.StartWorkEvent;
  import pomodo.events.StopWorkEvent;
  import pomodo.events.SubtractTimeEvent;
  import pomodo.events.TimeChangeEvent;
  import pomodo.models.Task;
  import pomodo.models.Workunit;
  
  [Bindable]
  public class TaskTracker extends EventDispatcher {
    private static var tracker:TaskTracker;
    
    private var timer:Timer;
            
    private var activeWorkunit:Workunit;
    
    private var wentAwayTime:Date;
        
    private var _selectedTask:Task;

    public var activeTask:Task;
   
    public var totalTaskTime:Number;
    
    public var latestTaskTime:Number;
    
    public function TaskTracker(enforcer:SingletonEnforcer) {
      super();
      
      timer = new Timer(1000); /* every second */
      timer.addEventListener(TimerEvent.TIMER, onTick);
    }

    private function onTick(event:TimerEvent):void {
      latestTaskTime = latestTaskTime + 1000;
      totalTaskTime = totalTaskTime + 1000;
      dispatchEvent(new TimeChangeEvent);
    }

    public function get selectedTask():Task {
      return _selectedTask;
    }
    
    public function set selectedTask(task:Task):void {
      if (!currentlyWorking()) {
        totalTaskTime = task.computedTotalTime;
      }
      _selectedTask = task;
    }
    
    public function currentlyWorking():Boolean {
      return timer.running;
    }
    
    public function startWork(task:Task = null):void {
      stopWork();
      if (task) {
        activeTask = task;
        _selectedTask = task;
      } else if (_selectedTask) {
        activeTask = _selectedTask;
      }
      if (!activeWorkunit) {
        activeWorkunit = new Workunit;
        activeWorkunit.startedOn = new Date;
        activeWorkunit.task = activeTask;
        activeWorkunit.user = Pomodo.models.currentUser;
        totalTaskTime = activeTask.computedTotalTime;
        latestTaskTime = 0;
      }
      timer.start();
      dispatchEvent(new StartWorkEvent);
    }

    public function resumeWork():void {
      timer.start();
    }
    
    public function stopWork(afterCallback:Function = null):void {
      if (activeWorkunit) {
        timer.stop();
        dispatchEvent(new StopWorkEvent);
        activeWorkunit.endedOn = new Date;
        activeWorkunit.workedMilliseconds = latestTaskTime;
        activeWorkunit.create(afterCallback);
        activeWorkunit = null;
        activeTask = null;
      } else if (afterCallback != null) {
        afterCallback(null);
      }
    }

    public function pauseWork():void {
      timer.stop();
    }
    
    public function subtractTime(time:Number):void {
      latestTaskTime = latestTaskTime - time;
      totalTaskTime = totalTaskTime - time;
      dispatchEvent(new SubtractTimeEvent(time));
    }
    
    public static function get instance():TaskTracker {
      initialize();
      return tracker;
    }
    
    public static function initialize():void {
      if (!tracker) tracker = new TaskTracker(new SingletonEnforcer);
    }

    public static function reset():void {
      tracker = null;  
    }
  }
}

class SingletonEnforcer {}