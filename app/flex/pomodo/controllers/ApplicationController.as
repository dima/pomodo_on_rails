package pomodo.controllers {
  import org.ruboss.Ruboss;
  import org.ruboss.controllers.RubossApplicationController;
  import org.ruboss.utils.RubossUtils;
  
  import pomodo.commands.*;
  import pomodo.models.*;

  public class ApplicationController extends RubossApplicationController {
    private static var controller:ApplicationController;
    
    public static var models:Array = [Account, Address, Assignment, Project, ProjectCategory, Sprint, Task, User, Workunit]; /* Models */
    
    public static var commands:Array = []; /* Commands */
    
    public function ApplicationController(enforcer:SingletonEnforcer, extraServices:Array,
      defaultServiceId:int = -1) {
      super(commands, models, extraServices, defaultServiceId);
    }
    
    public static function get instance():ApplicationController {
      if (controller == null) initialize();
      return controller;
    }
    
    public static function initialize(extraServices:Array = null, defaultServiceId:int = -1,
      airDatabaseName:String = null):void {
      if (!RubossUtils.isEmpty(airDatabaseName)) Ruboss.airDatabaseName = airDatabaseName;
      controller = new ApplicationController(new SingletonEnforcer, extraServices,
        defaultServiceId);
    }
  }
}

class SingletonEnforcer {}
