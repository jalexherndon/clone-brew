(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dojox/grid/DataGrid'], function(declare, DataGrid) {
    return declare('Brew.ui.grid.Grid', DataGrid, {
      canSort: function(sortColumnIndex) {
        return !this.getCell(sortColumnIndex - 1).disableSort && this.inherited(arguments);
      },
      getSortProps: function() {
        var cell, props;
        props = this.inherited(arguments);
        cell = this.getCell(this.getSortIndex());
        if (cell != null ? cell.sortField : void 0) {
          props[0].attribute = c.sortField;
        }
        return props;
      }
    });
  });

}).call(this);
