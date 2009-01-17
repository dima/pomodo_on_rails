package pomodo.models {
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.models.RxModel;
  
  [Resource(name="tasks")]
  [Bindable]
  public class Task extends RxModel {
    public static const LABEL:String = "name";
        
    public var name:String;

    public var notes:String;

    public var completed:Boolean;

    public var billedPercentage:int;
    
    [Ignored]
    public var totalTime:Number = 0;
    
    [Ignored]
    public var totalTimeToday:Number = 0;
    
    [Ignored]
    public var totalTimeThisWeek:Number = 0;
    
    [Ignored]
    public var totalTimeThisMonth:Number = 0;
    
    [Lazy]
    [BelongsTo]
    public var sprint:Sprint;

    [Lazy]
    [BelongsTo]
    public var user:User;

    [HasMany]
    public var workunits:ModelsCollection;
    
    public function Task() {
      super(LABEL);
    }
    
    [Ignored]
    public function get basicTotalTime():Number {
      var total:Number = new Number(0);
      for each (var unit:Workunit in workunits) {
        total += unit.workedMilliseconds;
      }
      return total;
    }
    
    [Ignored]
    public function get computedTotalTime():Number {
      return computeTotalTime(totalTime);
    }
    
    [Ignored]
    public function get computedTotalCost():Number {
      return computeTotalCost(computedTotalTime);
    }
    
    [Ignored]
    public function get computedTotalTimeToday():Number {
      return computeTotalTime(totalTimeToday);
    }
    
    [Ignored]
    public function get computedTotalCostToday():Number {
      return computeTotalCost(computedTotalTimeToday);
    }
    
    [Ignored]
    public function get computedTotalTimeThisWeek():Number {
      return computeTotalTime(totalTimeThisWeek);
    }
    
    [Ignored]
    public function get computedTotalCostThisWeek():Number {
      return computeTotalCost(computedTotalTimeThisWeek);
    }
    
    [Ignored]
    public function get computedTotalTimeThisMonth():Number {
      return computeTotalTime(totalTimeThisMonth);
    }
    
    [Ignored]
    public function get computedTotalCostThisMonth():Number {
      return computeTotalCost(computedTotalTimeThisMonth);
    }
    
    private function computeTotalTime(addTo:Number):Number {
      return basicTotalTime + addTo;
    }
    
    private function computeTotalCost(value:Number):Number {
      return (value * sprint.billedHourlyRate) / 3600000;
    }
  }
}