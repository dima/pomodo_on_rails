package pomodo.models {
  import org.ruboss.collections.ModelsCollection;
  import org.ruboss.models.RubossModel;
  
  [Resource(name="users")]
  [Bindable]
  public class User extends RubossModel {
    public static const LABEL:String = "title";

    public var title:String;

    [Ignored]
    public var login:String;
    
    [Lazy]
    [BelongsTo]
    public var address:Address;
    
    [Lazy]
    [BelongsTo]
    public var account:Account;

    [HasMany]
    public var tasks:ModelsCollection;
    
    [HasMany]
    public var assignments:ModelsCollection;
    
    [HasMany(through="Assignments")]
    public var projects:ModelsCollection;
    
    public function User() {
      super(LABEL);
    }
  }
}
