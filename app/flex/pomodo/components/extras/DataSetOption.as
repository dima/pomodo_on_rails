package pomodo.components.extras {
  [Bindable]
  public class DataSetOption {
    
    public var label:String;
    
    public var clazz:Class;
    
    public function DataSetOption(label:String, clazz:Class) {
      this.label = label;
      this.clazz = clazz;
    }
  }
}