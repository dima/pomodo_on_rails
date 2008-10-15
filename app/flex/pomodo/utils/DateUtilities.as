package pomodo.utils {
	public class DateUtilities {
	  public static const MILLISECOND:Number = 1;
	  public static const SECOND:Number = MILLISECOND * 1000;
	  public static const MINUTE:Number = SECOND * 60;
	  public static const HOUR:Number = MINUTE * 60;
	  public static const DAY:Number = HOUR * 24;
	  public static const WEEK:Number = DAY * 7;
	
	  public static function addTo(dOriginal:Date, nYears:Number = 0, nMonths:Number = 0, nDays:Number = 0, 
	    nHours:Number = 0, nMinutes:Number = 0, nSeconds:Number = 0, nMilliseconds:Number = 0):Date {
	    var dNew:Date = new Date(dOriginal.getTime());
	    dNew.setFullYear(dNew.getFullYear() + nYears);
	    dNew.setMonth(dNew.getMonth() + nMonths);
	    dNew.setDate(dNew.getDate() + nDays);
	    dNew.setHours(dNew.getHours() + nHours);
	    dNew.setMinutes(dNew.getMinutes() + nMinutes);
	    dNew.setSeconds(dNew.getSeconds() + nSeconds);
	    dNew.setMilliseconds(dNew.getMilliseconds() + nMilliseconds);
	    return dNew;
	  }
	
	  public static function elapsedDate(dOne:Date, dTwo:Date = null):Date {
	    if(dTwo == null) {
	      dTwo = new Date();
	    }
	    return new Date(dOne.getTime() - dTwo.getTime());
	  }
	
	  public static function elapsedMilliseconds(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
	    if(bDisregard) {
	      return elapsedDate(dOne, dTwo).getUTCMilliseconds();
	    } else {
	      return (dOne.getTime() - dTwo.getTime());
	    }
	  }
	
	  public static function elapsedSeconds(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
	    if(bDisregard) {
	      return (elapsedDate(dOne, dTwo).getUTCSeconds());
	    }	else {
	      return Math.floor(elapsedMilliseconds(dOne, dTwo) / SECOND);
	    }
	  }
	
	  public static function elapsedMinutes(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
	    if(bDisregard) {
	      return (elapsedDate(dOne, dTwo).getUTCMinutes());
	    }	else {
	      return Math.floor(elapsedMilliseconds(dOne, dTwo) / MINUTE);
	    }
	  }
	
	  public static function elapsedHours(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
	    if(bDisregard) {
	      return (elapsedDate(dOne, dTwo).getUTCHours());
	    } else {
	      return Math.floor(elapsedMilliseconds(dOne, dTwo) / HOUR);
	    }
	  }
	
	  public static function elapsedDays(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
	    if(bDisregard) {
	      return (elapsedDate(dOne, dTwo).getUTCDate());
	    } else {
	      return Math.floor(elapsedMilliseconds(dOne, dTwo) / DAY);
	    }
	  }
	
	  public static function elapsedMonths(dOne:Date, dTwo:Date = null, bDisregard:Boolean = false):Number {
	    if(bDisregard) {
	      return (elapsedDate(dOne, dTwo).getUTCMonth());
	    }	else {
	      return (elapsedDate(dOne, dTwo).getUTCMonth() + elapsedYears(dOne, dTwo) * 12);
	    }
	  }
	
	  public static function elapsedYears(dOne:Date, dTwo:Date = null):Number {
	    return (elapsedDate(dOne, dTwo).getUTCFullYear() - 1970);
	  }
	
	  public static function elapsed(dOne:Date, dTwo:Date = null):Object {
	    var oElapsed:Object = new Object();
	    oElapsed.years = elapsedYears(dOne, dTwo);
	    oElapsed.months = elapsedMonths(dOne, dTwo, true);
	    oElapsed.days = elapsedDays(dOne, dTwo, true);
	    oElapsed.hours = elapsedHours(dOne, dTwo, true);
	    oElapsed.minutes = elapsedMinutes(dOne, dTwo, true);
	    oElapsed.seconds = elapsedSeconds(dOne, dTwo, true);
	    oElapsed.milliseconds = elapsedMilliseconds(dOne, dTwo, true);
	    return oElapsed;
	  }
	}
}