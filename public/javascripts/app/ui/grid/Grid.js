(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dgrid/OnDemandGrid', 'dojox/widget/Standby', 'dojo/_base/window'], function(declare, OnDemandGrid, Standby, win) {
    return declare('Brew.ui.grid.Grid', OnDemandGrid, {
      postCreate: function() {
        var grid;
        grid = this;
        this.on(".dgrid-cell.clickable:click", function(e) {
          var beerId;
          beerId = grid.row(e).id;
          return Brew.util.navigation.HashManager.setHash('/beers/' + beerId);
        });
        return this.inherited(arguments);
      },
      refresh: function() {
        this.getStandBy().show();
        return this.inherited(arguments);
      },
      _processScroll: function(evt) {
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
