package pomodo.models {
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.models.RxTreeModel;
  
  [Resource(name="project_categories")]
  [Bindable]
  public class ProjectCategory extends RxTreeModel {
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
