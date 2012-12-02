(function() {

  define('Brew/content/library/LibraryPage', ['dojo/_base/declare', 'Brew/ui/_Page', 'Brew/data/BreweryDBStore', 'Brew/ui/grid/Grid'], function(declare, _Page, BreweryDBStore, Grid) {
    return declare('Brew/content/library/LibraryPage', _Page, {
      postCreate: function() {
        this.inherited(arguments);
        return this.addChild(new Grid({
          id: 'brew-grid',
          store: new BreweryDBStore({
            target: '/beers/'
          }),
          rowsPerPage: 50,
          cellOverClass: '',
          fetchText: 'fetch',
          structure: Brew.ui.grid.StructureFactory.structureFor('beers'),
          autoWidth: true,
          autoHeight: true,
          onRowClick: function(e) {
            var beer, _base;
            beer = e.grid.getItem(e.rowIndex);
            return typeof (_base = e.cell).action === "function" ? _base.action(beer) : void 0;
          }
        }));
      }
    });
  });

}).call(this);
