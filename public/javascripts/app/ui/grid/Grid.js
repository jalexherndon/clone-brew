(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dojo/_base/lang', 'dgrid/Grid', 'dgrid/extensions/Pagination', 'dgrid/extensions/DijitRegistry', 'dojox/widget/Standby', 'dojo/_base/window'], function(declare, lang, Grid, Pagination, DijitRegistry, Standby, win) {
    return declare('Brew.ui.grid.Grid', [Grid, Pagination, DijitRegistry], {
      postCreate: function() {
        var _this = this;
        this.on(".dgrid-cell.clickable:click", function(e) {
          var beerId;
          beerId = _this.row(e).id;
          return Brew.util.navigation.HashManager.setHash('/beer/detail/' + beerId);
        });
        return this.inherited(arguments);
      },
      gotoPage: function() {
        this.getStandBy().show();
        return this.inherited(arguments);
      },
      searchFor: function(queryString, type) {
        this.store.target = 'brewery_db/search';
        this.query = lang.mixin(this.query, {
          type: type,
          q: queryString
        });
        return this.refresh();
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
