(function() {

  define('Brew/content/library/LibraryPage', ['dojo/_base/declare', 'Brew/ui/_Page', 'Brew/data/Store', 'dojox/grid/DataGrid', 'dojo/query'], function(declare, _Page, BrewStore, DataGrid, query) {
    return declare('Brew.content.library.LibraryPage', _Page, {
      postCreate: function() {
        var grid;
        this.inherited(arguments);
        grid = new DataGrid({
          id: 'brew-grid',
          store: new BrewStore({
            target: '/beers/'
          }),
          cellOverClass: '',
          structure: Brew.ui.grid.StructureFactory.structureFor('beers'),
          autoWidth: true,
          autoHeight: true
        });
        return this.addChild(grid);
      }
    });
  });

}).call(this);
