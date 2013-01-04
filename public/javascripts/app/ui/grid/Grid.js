(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dojo/_base/lang', 'dgrid/Grid', 'dgrid/extensions/Pagination', 'dgrid/extensions/DijitRegistry', 'dojox/widget/Standby', 'dojo/_base/window'], function(declare, lang, Grid, Pagination, DijitRegistry, Standby, win) {
    return declare('Brew.ui.grid.Grid', [Grid, Pagination, DijitRegistry], {
      postCreate: function() {
        var _ref, _ref1,
          _this = this;
        this.inherited(arguments);
        this.on(".dgrid-cell.clickable:click", function(e) {
          var beerId;
          beerId = _this.row(e).id;
          return Brew.util.navigation.HashManager.setHash('/beer/detail/' + beerId);
        });
        if ((_ref = this.store) != null) {
          _ref.on("beforequery", function() {
            return _this.getStandBy().show();
          });
        }
        return (_ref1 = this.store) != null ? _ref1.on("load", function() {
          return _this.getStandBy().hide();
        }) : void 0;
      },
      searchFor: function(queryString, type) {
        this.store.target = 'brewery_db/search';
        queryString = queryString.replace(/\s/, "+");
        this.query = lang.mixin(this.query, {
          type: type,
          q: queryString
        });
        return this.refresh();
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
