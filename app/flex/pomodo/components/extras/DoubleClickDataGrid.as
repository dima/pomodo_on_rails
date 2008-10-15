package pomodo.components.extras {
  import flash.events.MouseEvent;
  
  import mx.controls.DataGrid;
  import mx.controls.dataGridClasses.DataGridColumn;
  import mx.controls.listClasses.IDropInListItemRenderer;
  import mx.controls.listClasses.IListItemRenderer;
  import mx.events.DataGridEvent;

  public class DoubleClickDataGrid extends DataGrid {
    private var triggeredEditable:Boolean = false;
    
    public function DoubleClickDataGrid() {
      super();
      doubleClickEnabled = true;
    }
  
    override protected function mouseDoubleClickHandler(event:MouseEvent):void {
      var currentRenderer:IListItemRenderer =  mouseEventToItemRenderer(event);

      if (itemRenderer && itemRenderer != itemEditorInstance) {
        var dropInItemRenderer:IDropInListItemRenderer = IDropInListItemRenderer(currentRenderer);
        if (columns[dropInItemRenderer.listData.columnIndex].editable) {
          var currentColumn:DataGridColumn = columns[dropInItemRenderer.listData.columnIndex];
          var dataGridEvent:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGINNING, false, true);
          dataGridEvent.columnIndex = dropInItemRenderer.listData.columnIndex;
          dataGridEvent.dataField = currentColumn.dataField;
          dataGridEvent.rowIndex = dropInItemRenderer.listData.rowIndex + verticalScrollPosition;
          dataGridEvent.itemRenderer = currentRenderer;
          dispatchEvent(dataGridEvent);
        }
      }
  
      super.mouseDoubleClickHandler(event);
    }

    override protected function mouseUpHandler(event:MouseEvent):void {
      var currentRenderer:IListItemRenderer = mouseEventToItemRenderer(event);
      var currentColumn:DataGridColumn;
      if (currentRenderer) {
        try {
          var dropInItemRenderer:IDropInListItemRenderer = IDropInListItemRenderer(currentRenderer);
          if (columns[dropInItemRenderer.listData.columnIndex].editable) {
            currentColumn = DataGridColumn(columns[dropInItemRenderer.listData.columnIndex]);
            currentColumn.editable = false;
          }          
        } catch (e:Error) {
          // nothing to do here
        }

      }
  
      super.mouseUpHandler(event);
      if (currentColumn) {
        currentColumn.editable = true;
      }
    }
  }
}