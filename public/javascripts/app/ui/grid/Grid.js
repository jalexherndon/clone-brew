(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dojox/grid/DataGrid'], function(declare, DataGrid) {
    return declare('Brew.ui.grid.Grid', DataGrid, {
      canSort: function(sortColumnIndex) {
        return !this.getCell(sortColumnIndex - 1).disableSort && this.inherited(arguments);
      },
      getSortProps: function() {
        var c, props;
        props = this.inherited(arguments);
        c = this.getCell(this.getSortIndex());
        if (c != null ? c.sortField : void 0) {
          props[0].attribute = c.sortField;
        }
        return props;
      }
    });
  });

}).call(this);
