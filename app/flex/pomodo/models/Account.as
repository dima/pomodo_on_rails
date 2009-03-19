package pomodo.models {
  import org.restfulx.models.RxModel;
  
  [Resource(name="accounts")]
  [Bindable]
  public class Account extends RxModel {
    public static const LABEL:String = "login";

    public var login:String;
    
    public var name:String;
    
    public var email:String;
    
    public var password:String;
    
    public var passwordConfirmation:String;
    
    [Ignored]
    public var photoUrl:String;
    
    public function Account() {
      super(LABEL);
    }
  }
}
