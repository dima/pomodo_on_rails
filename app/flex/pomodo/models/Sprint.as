package pomodo.models {
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.models.RxModel;
  
  [Resource(name="sprints")]
  [Bindable]
  public class Sprint extends RxModel {
    public static const LABEL:String = "name";
    
    public var name:String;

    [DateTime]
    public var dueBy:Date = new Date;

    public var billedHourlyRate:int;

    [Lazy]
    [BelongsTo]
    public var project:Project;

    [HasMany]
    public var tasks:ModelsCollection;
    
    public function Sprint() {
      super(LABEL);
    }
    
    [Ignored]
    public function get qualifiedName():String {
      return project.name + ": " + name;
    }
    
    [Ignored]
    public function get computedTotalTime():Number {
      return computeTotal("computedTotalTime");
    }
    
    [Ignored]
    public function get computedTotalCost():Number {
      return computeTotal("computedTotalCost");
    }
    
    [Ignored]
    public function get computedTotalTimeToday():Number {
      return computeTotal("computedTotalTimeToday");
    }
    
    [Ignored]
    public function get computedTotalCostToday():Number {
      return computeTotal("computedTotalCostToday");
    }
    
    [Ignored]
    public function get computedTotalTimeThisWeek():Number {
      return computeTotal("computedTotalTimeThisWeek");
    }
    
    [Ignored]
    public function get computedTotalCostThisWeek():Number {
      return computeTotal("computedTotalCostThisWeek");
    }
    
    [Ignored]
    public function get computedTotalTimeThisMonth():Number {
      return computeTotal("computedTotalTimeThisMonth");
    }
    
    [Ignored]
    public function get computedTotalCostThisMonth():Number {
      return computeTotal("computedTotalCostThisMonth");
    }
    
    private function computeTotal(property:String):Number {
      var total:Number = new Number(0);
      for each (var task:Task in tasks) {
        total += task[property];
      }
      return total;
    }
  }
}
