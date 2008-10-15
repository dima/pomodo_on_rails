package pomodo.events {
  import flash.events.Event;

  public class StartWorkEvent extends Event {
    public static var ID:String = "startWork";
    
    public function StartWorkEvent() {  
      super(ID, false, false);
    }
  }
}