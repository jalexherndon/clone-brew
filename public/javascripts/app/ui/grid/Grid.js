(function() {

  define('Brew/ui/grid/Grid', ['dojo/_base/declare', 'dojo/_base/lang', 'dgrid/Grid', 'dgrid/extensions/Pagination', 'dgrid/extensions/DijitRegistry'], function(declare, lang, Grid, Pagination, DijitRegistry) {
    return declare('Brew.ui.grid.Grid', [Grid, Pagination, DijitRegistry], {
      showLoadingMask: false,
      postCreate: function() {
        var _this = this;
        this.inherited(arguments);
        return this.on(".dgrid-cell.clickable:click", function(e) {
          var beerId;
          beerId = _this.row(e).id;
          return Brew.util.navigation.HashManager.setHash('/beer/detail/' + beerId);
        });
      },
      searchFor: function(queryString, type) {
        this.store.target = 'brewery_db/search';
        queryString = queryString.replace(/\s/, "+");
        this.query = lang.mixin(this.query, {
          type: type,
          q: queryString
        });
        return this.refresh();
      }
    });
  });

}).call(this);
