package pomodo.models {
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.models.RxModel;
  
  [Resource(name="projects")]
  [Bindable]
  public class Project extends RxModel {
    public static const LABEL:String = "name";
    public static const ANY:Project = new Project("Any");
    
    public var name:String;

    public var notes:String;

    public var completed:Boolean;

    public var billedHourlyRate:int;
    
    [BelongsTo]
    public var projectCategory:ProjectCategory;

    [HasMany]
    public var sprints:ModelsCollection;
    
    [HasMany]
    public var assignments:ModelsCollection;
    
    [HasMany(through="Assignments")]
    public var users:ModelsCollection;
    
    public function Project(name:String = "") {
      super(LABEL);
      this.name = name;
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
      for each (var sprint:Sprint in sprints) {
        total += sprint[property];
      }
      return total;
    }
  }
}
