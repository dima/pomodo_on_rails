package pomodo.models {
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.models.RxModel;
  
  [Resource(name="users")]
  [Bindable]
  public class User extends RxModel {
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
