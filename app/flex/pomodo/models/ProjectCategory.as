package pomodo.models {
  import org.ruboss.collections.ModelsCollection;
  import org.ruboss.models.RubossTreeModel;
  
  [Resource(name="project_categories")]
  [Bindable]
  public class ProjectCategory extends RubossTreeModel {
    public static const LABEL:String = "name";

    public var name:String;

    public var description:String;
    
    [BelongsTo]
    public var parent:ProjectCategory;
    
    [HasMany]
    public var projects:ModelsCollection;

    public function ProjectCategory() {
      super(LABEL);
    }
  }
}
