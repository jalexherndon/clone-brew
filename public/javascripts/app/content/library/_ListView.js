(function() {

  define('Brew/content/library/_ListView', ['dojo/_base/declare', 'dojo/_base/lang', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'Brew/ui/grid/Grid', 'Brew/content/library/ListViewSearch', 'dojox/widget/Standby', 'dojo/_base/window'], function(declare, lang, _WidgetBase, _TemplatedMixin, Grid, ListViewSearch, Standby, win) {
    var FILTER_CT_CLASS, GRID_CT_CLASS, GRID_DIV_CLASS, SEARCH_CT_CLASS;
    GRID_CT_CLASS = "grid-ct";
    GRID_DIV_CLASS = "grid-div";
    FILTER_CT_CLASS = "filter-ct";
    SEARCH_CT_CLASS = "search-ct";
    return declare('Brew.content.library._ListView', [_WidgetBase, _TemplatedMixin], {
      baseClass: 'brew-list-view',
      gridClass: 'sage',
      templateString: "      <div class=\"${gridClass}\">        <div class=\"left-column\">          <div class=\"" + SEARCH_CT_CLASS + "\"></div>          <div class=\"" + FILTER_CT_CLASS + "\"></div>        </div>        <div class=\"" + GRID_CT_CLASS + "\">          <div class=\"" + GRID_DIV_CLASS + "\"></div>        </div>      </div>    ",
      postCreate: function() {
        var grid;
        this.inherited(arguments);
        grid = this._attachGrid();
        return this._attachSearch(grid);
      },
      getGridConfig: function(container) {
        throw new Brew.util.Errors.UNIMPLEMENTED_METHOD(arguments.callee);
      },
      getSearchBarConfig: function() {
        throw new Brew.util.Errors.UNIMPLEMENTED_METHOD(arguments.callee);
      },
      getFilterPane: function() {
        throw new Brew.util.Errors.UNIMPLEMENTED_METHOD(arguments.callee);
      },
      _attachSearch: function(grid) {
        var srcNodeRef;
        srcNodeRef = dojo.query("." + SEARCH_CT_CLASS, this.domNode)[0];
        return new ListViewSearch(lang.mixin({
          grid: grid
        }, this.getSearchBarConfig()), srcNodeRef);
      },
      _attachGrid: function() {
        var grid, srcNodeRef, _ref, _ref1,
          _this = this;
        srcNodeRef = dojo.query("." + GRID_DIV_CLASS, this.domNode)[0];
        grid = new Grid(this.getGridConfig(), srcNodeRef);
        if ((_ref = grid.store) != null) {
          _ref.on("beforequery", function() {
            return _this._getStandBy().show();
          });
        }
        if ((_ref1 = grid.store) != null) {
          _ref1.on("load", function() {
            return _this._getStandBy().hide();
          });
        }
        grid.refresh();
        return grid;
      },
      _getStandBy: function() {
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
