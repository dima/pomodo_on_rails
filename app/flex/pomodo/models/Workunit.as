package pomodo.models {
  import org.restfulx.models.RxModel;
  
  [Resource(name="workunits")]
  [Bindable]
  public class Workunit extends RxModel {
    public static const LABEL:String = "startedOn";
    
    [DateTime]
    public var startedOn:Date;

    [DateTime]
    public var endedOn:Date;
    
    public var workedMilliseconds:Number = 0;

    [Lazy]
    [BelongsTo]
    public var user:User;

    [Lazy]
    [BelongsTo]
    public var task:Task;

    public function Workunit() {
      super(LABEL);
    }
  }
}
