(function() {

  define('Brew/content/library/_ListView', ['dojo/_base/declare', 'dojo/_base/lang', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'Brew/ui/grid/Grid', 'Brew/content/library/ListViewSearch'], function(declare, lang, _WidgetBase, _TemplatedMixin, Grid, ListViewSearch) {
    var FILTER_CT_CLASS, GRID_CT_CLASS, SEARCH_CT_CLASS;
    GRID_CT_CLASS = "grid-ct";
    FILTER_CT_CLASS = "filter-ct";
    SEARCH_CT_CLASS = "search-ct";
    return declare('Brew.content.library._ListView', [_WidgetBase, _TemplatedMixin], {
      baseClass: 'brew-list-view',
      gridClass: 'sage',
      templateString: "      <div class=\"${baseClass} ${gridClass}\">        <div class=\"left-column\">          <div class=\"" + SEARCH_CT_CLASS + "\"></div>          <div class=\"" + FILTER_CT_CLASS + "\"></div>        </div>        <div class=\"" + GRID_CT_CLASS + "\"></div>      </div>    ",
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
        var grid, srcNodeRef;
        srcNodeRef = dojo.query("." + GRID_CT_CLASS, this.domNode)[0];
        grid = new Grid(this.getGridConfig(), srcNodeRef);
        grid.refresh();
        return grid;
      }
    });
  });

}).call(this);
