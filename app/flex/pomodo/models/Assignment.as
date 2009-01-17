package pomodo.models {
  import org.restfulx.models.RxModel;
  
  [Resource(name="assignments")]
  [Bindable]
  public class Assignment extends RxModel {
    public static const LABEL:String = "id";

    [BelongsTo]
    public var user:User;

    [BelongsTo]
    public var project:Project;

    public function Assignment() {
      super(LABEL);
    }
  }
}
