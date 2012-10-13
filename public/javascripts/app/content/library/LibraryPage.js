(function() {

  define("Brew/content/library/LibraryPage", ["dojo/_base/declare", "Brew/ui/_Page", "dojox/data/RailsStore", "dojox/grid/DataGrid", "dojo/query"], function(declare, _Page, RailsStore, DataGrid, query) {
    return declare("Brew.content.library.LibraryPage", _Page, {
      postCreate: function() {
        var grid, layout, store;
        this.inherited(arguments);
        store = new RailsStore({
          target: "/beers/"
        });
        layout = [
          {
            name: "Name",
            field: "name",
            width: "100px"
          }, {
            name: "Brewery",
            field: "brewery",
            width: "125px",
            formatter: this._nameFormatter
          }, {
            name: "Description",
            field: "description",
            width: "400px"
          }
        ];
        grid = new DataGrid({
          id: "brew-grid",
          store: store,
          structure: layout,
          autoWidth: true,
          autoHeight: true
        });
        return this.addChild(grid);
      },
      _nameFormatter: function(value, rowIdx) {
        return value.name;
      }
    });
  });

}).call(this);
