package pomodo.controllers {
  import org.restfulx.Rx;
  import org.restfulx.collections.RxCollection;
  import org.restfulx.events.CacheUpdateEvent;
  import org.restfulx.utils.RxUtils;
  
  import pomodo.models.Project;
  import pomodo.models.ProjectCategory;
  import pomodo.models.Sprint;
  import pomodo.models.Task;
  import pomodo.models.User;
  
  [Bindable]
  public class ModelsController {
        
    private static var controller:ModelsController;

    private var _selectedProject:Project;
    
    public var currentUser:User;
    
    public var projectCategories:RxCollection;
        
    public var projectsAndAny:RxCollection;
    
    public var projects:RxCollection;
    
    public var incompleteTasks:RxCollection;
    
    public var tasks:RxCollection;
        
    public var sprints:RxCollection;
    
    public function ModelsController(enforcer:SingletonEnforcer) {
      Rx.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
      Rx.models.index(Project);
    }

    private function onCacheUpdate(event:CacheUpdateEvent):void {
      if (event.isFor(Project)) {
        projectsAndAny = Rx.merge(Rx.models.cached(Project), [Project.ANY]);
        projects = Rx.models.cached(Project);
        sprints = Rx.models.cached(Sprint);
        tasks = Rx.models.cached(Task);
        incompleteTasks = Rx.filter(Rx.models.cached(Task), filterByCompletionAndProject);
      } else if (event.isFor(ProjectCategory)) {
        projectCategories = Rx.filter(Rx.models.cached(ProjectCategory), filterByCategoryWithNoParent);
      } else if (event.isFor(Task)) {
        tasks = Rx.models.cached(Task);
        incompleteTasks = Rx.filter(Rx.models.cached(Task), filterByCompletionAndProject); 
      } else {
        var prop:String = RxUtils.toCamelCase(Rx.models.state.controllers[event.fqn]);
        if (hasOwnProperty(prop)) {
          this[prop] = Rx.models.cache.data[event.fqn];
        }
      }
    }
    
    private function filterByCategoryWithNoParent(item:ProjectCategory):Boolean {
      return item.parent == null;
    }

    public function get selectedProject():Project {
      return _selectedProject;
    }
    
    public function set selectedProject(project:Project):void {
      _selectedProject = (Project.ANY == project) ? null : project;
      filterTasks();
    }

    public function filterTasks(text:String = null):void {
      if (!RxUtils.isEmpty(text)) {
        incompleteTasks.filterFunction = function(task:Task):Boolean {
          return filterByCompletionAndProject(task) && (task.name.search(new RegExp(text, "i")) != -1);
        };
      } else {
        incompleteTasks.filterFunction = filterByCompletionAndProject;
      }
      incompleteTasks.refresh();
    }

    public function filterByCompletionAndProject(task:Task):Boolean {
      return incompleteTask(task) && taskOfSelectedProject(task);
    }
    
    public function incompleteTask(task:Task):Boolean {
      return !task.completed;
    }
    
    public function taskOfSelectedProject(task:Task):Boolean {
      return (selectedProject) ? task.sprint.project == selectedProject : true;
    }
    
    public static function get instance():ModelsController {
      initialize();
      return controller;
    }
      
    public static function initialize():void {
      if (!controller) controller = new ModelsController(new SingletonEnforcer);      
    }
    
    public static function reset():void {
      controller = null;  
    }
  }
}

class SingletonEnforcer {}