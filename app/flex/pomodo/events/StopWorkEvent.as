package pomodo.events {
  import flash.events.Event;

  public class StopWorkEvent extends Event {
    public static var ID:String = "stopWork";
    
    public function StopWorkEvent() {  
      super(ID, false, false);
    }
  }
}