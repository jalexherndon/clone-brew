(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dgrid/Grid', 'dgrid/extensions/Pagination', 'dojox/widget/Standby', 'dojo/_base/window'], function(declare, Grid, Pagination, Standby, win) {
    return declare('Brew.ui.grid.Grid', [Grid, Pagination], {
      postCreate: function() {
        var grid;
        grid = this;
        this.on(".dgrid-cell.clickable:click", function(e) {
          var beerId;
          beerId = grid.row(e).id;
          return Brew.util.navigation.HashManager.setHash('/beer/detail/' + beerId);
        });
        return this.inherited(arguments);
      },
      gotoPage: function() {
        this.getStandBy().show();
        return this.inherited(arguments);
      },
      _updateNavigation: function() {
        var ret;
        ret = this.inherited(arguments);
        this.getStandBy().hide();
        return ret;
      },
      getStandBy: function() {
        if (!(this.standby != null)) {
          this.standby = new Standby({
            target: this.domNode
          });
          win.body().appendChild(this.standby.domNode);
          this.standby.startup();
        }
        return this.standby;
      }
    });
  });

}).call(this);
