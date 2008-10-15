package pomodo.events {
  import flash.events.Event;

  public class TimeChangeEvent extends Event {
    public static var ID:String = "timeChange";
    
    public function TimeChangeEvent() {  
      super(ID, false, false);
    }
  }
}