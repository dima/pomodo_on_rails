package pomodo.events {
  import flash.events.Event;
  
  import pomodo.utils.DateUtilities;

  public class SubtractTimeEvent extends Event {
    
    public static var ID:String = "subtractTime";
    
    public var time:Number;
    
    public function SubtractTimeEvent(time:Number) {
      super(ID, false, false);
      this.time = time;
    }
  }
}