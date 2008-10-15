package pomodo.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(name="assignments")]
  [Bindable]
  public class Assignment extends RubossModel {
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
