(function() {

  define('Brew/content/library/BeerPage', ['dojo/_base/declare', 'Brew/content/library/_LibraryPage', 'dojo/store/JsonRest', 'Brew/data/BreweryDBStore', 'Brew/ui/grid/Grid', 'dojo/dom-class'], function(declare, _LibraryPage, JsonRest, BreweryDBStore, Grid, domClass) {
    return declare('Brew.content.library.BeerPage', _LibraryPage, {
      getGrid: function() {
        return new Grid({
          store: new BreweryDBStore({
            target: '/beers/'
          }),
          columns: Brew.ui.grid.StructureFactory.structureFor('beers'),
          rowsPerPage: 50,
          pagingTextBox: true
        });
      }
    });
  });

}).call(this);
