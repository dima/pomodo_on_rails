package pomodo.controllers {
  import flash.utils.getQualifiedClassName;
  
  import mx.collections.ArrayCollection;
  
  import org.restfulx.Rx;
  import org.restfulx.events.CacheUpdateEvent;
  
  import pomodo.models.Project;
  
  public class StatisticsController {
    private static var controller:StatisticsController;
    
    [Bindable]
    public var totalTimeNumbers:ArrayCollection = new ArrayCollection;
    
    [Bindable]
    public var totalCostNumbers:ArrayCollection = new ArrayCollection;

    public function StatisticsController(enforcer:SingletonEnforcer) {
      Rx.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
      Rx.http(function(result:Object):void {
        totalTimeNumbers.addItem({
          totalTimeToday: result.total_time_today.toString(), 
          totalTimeThisWeek: result.total_time_this_week.toString(),
          totalTimeThisMonth: result.total_time_this_month.toString()
        });
      }).invoke("stats/summary");
    }
    
    private function onCacheUpdate(event:CacheUpdateEvent):void {
      if (event.isFor(Project)) {
        var totalCostToday:Number = new Number(0);
        var totalCostThisWeek:Number = new Number(0);
        var totalCostThisMonth:Number = new Number(0);
        for each (var project:Project in Rx.models.cached(Project)) {
          totalCostToday += project.computedTotalCostToday;
          totalCostThisWeek += project.computedTotalCostThisWeek;
          totalCostThisMonth += project.computedTotalCostThisMonth;
        }
        totalCostNumbers.addItem({
          totalCostToday: totalCostToday,
          totalCostThisWeek: totalCostThisWeek,
          totalCostThisMonth: totalCostThisMonth
        });
      }
    }

    public static function get instance():StatisticsController {
      initialize();
      return controller;
    }
    
    public static function initialize():void {
      if (!controller) controller = new StatisticsController(new SingletonEnforcer);
    }
    
    public static function reset():void {
      controller = null;  
    }
  }
}

class SingletonEnforcer {}