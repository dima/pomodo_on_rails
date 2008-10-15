package pomodo.controllers {
  import org.ruboss.Ruboss;
  import org.ruboss.controllers.RubossCommandsController;
  import org.ruboss.utils.RubossUtils;
  
  import pomodo.commands.*;
  import pomodo.models.*;

  public class PomodoController extends RubossCommandsController {
    private static var controller:PomodoController;
    
    public static var models:Array = [Account, Address, Assignment, Project, ProjectCategory, Sprint, Task, User, Workunit]; /* Models */
    
    public function PomodoController(enforcer:SingletonEnforcer, extraServices:Array,
      defaultServiceId:int = -1) {
      super([] /* Commands */, 
        models, extraServices, defaultServiceId);
    }
    
    public static function get instance():PomodoController {
      if (controller == null) initialize();
      return controller;
    }
    
    public static function initialize(extraServices:Array = null, defaultServiceId:int = -1,
      airDatabaseName:String = null):void {
      if (!RubossUtils.isEmpty(airDatabaseName)) Ruboss.airDatabaseName = airDatabaseName;
      controller = new PomodoController(new SingletonEnforcer, extraServices,
        defaultServiceId);
      Ruboss.commands = controller;
    }
  }
}

class SingletonEnforcer {}
