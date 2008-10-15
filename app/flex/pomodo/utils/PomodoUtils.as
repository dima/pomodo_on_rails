package pomodo.utils {
  import mx.formatters.CurrencyFormatter;
  import mx.formatters.DateFormatter;
  
  public class PomodoUtils {
    private static var dateFormatter:DateFormatter;
    private static var costFormatter:CurrencyFormatter;
    
    public static function getTimeFormatter():DateFormatter {
      if (!dateFormatter) {
        var dateFormatter:DateFormatter = new DateFormatter;
        dateFormatter.formatString = "JJ hours NN minutes SS seconds";
      }
      return dateFormatter;
    }
    
    public static function getCostFormatter():CurrencyFormatter {
      if (!costFormatter) {
        var costFormatter:CurrencyFormatter = new CurrencyFormatter;
        costFormatter.currencySymbol = "$";
        costFormatter.precision = 2;
        costFormatter.rounding = "up";
        costFormatter.decimalSeparatorTo = ".";
        costFormatter.thousandsSeparatorTo = ",";
        costFormatter.useThousandsSeparator = true;
      }
      return costFormatter;
    }
    
    [Bindable(event="propertyChange")]
    public static function getFormattedTime(milliseconds:Number):String {
      if (isNaN(milliseconds)) return "";
      
      var hours:int = Math.floor(milliseconds/3600000);
      var minutes:int = Math.floor((milliseconds - hours*3600000)/60000);
      var seconds:int = Math.floor((milliseconds - hours*3600000 - minutes*60000)/1000);
      return formatTime(hours) + ":" + formatTime(minutes) + ":" + formatTime(seconds); 
    }
    
    [Bindable(event="propertyChange")]
    public static function getWordFormattedTime(milliseconds:Number):String {
      var timeParts:Array = getFormattedTime(milliseconds).split(":");
      return wordFormatTime(timeParts[0], "hours") + wordFormatTime(timeParts[1], "minutes") + 
        wordFormatTime(timeParts[2], "seconds");
    }
    
    private static function wordFormatTime(time:String, suffix:String):String {
      if (time != "00") {
        return parseInt(time) + " " + suffix;
      } else {
        return "";
      }
    }
    
    private static function formatTime(time:int):String {
      return (time < 10) ? "0" + time : String(time);
    }
  }
}