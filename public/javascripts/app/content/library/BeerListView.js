(function() {

  define('Brew/content/library/BeerListView', ['dojo/_base/declare', 'Brew/content/library/_ListView', 'Brew/data/BreweryDBStore'], function(declare, _ListView, BreweryDBStore) {
    return declare('Brew.content.library.BeerListView', _ListView, {
      getGridConfig: function() {
        return {
          store: new BreweryDBStore({
            target: '/beers'
          }),
          columns: Brew.ui.grid.StructureFactory.structureFor('beers'),
          rowsPerPage: 50,
          pagingTextBox: true
        };
      },
      getSearchBarConfig: function() {
        return {
          searchType: 'beer'
        };
      }
    });
  });

}).call(this);
