package pomodo.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(name="accounts")]
  [Bindable]
  public class Account extends RubossModel {
    public static const LABEL:String = "login";

    public var login:String;
    
    public var name:String;
    
    public var email:String;
    
    public var password:String;
    
    public var passwordConfirmation:String;
    
    [Ignored]
    public var photoUrl:String;
    
    [Ignored]
    public var sessionToken:String;
    
    public function Account() {
      super(LABEL);
    }
  }
}
