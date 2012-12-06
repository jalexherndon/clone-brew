(function() {

  define('Brew/content/library/LibraryPage', ['dojo/_base/declare', 'Brew/ui/_Page', 'dojo/store/JsonRest', 'Brew/data/BreweryDBStore', 'Brew/ui/grid/Grid', 'dojo/dom-class'], function(declare, _Page, JsonRest, BreweryDBStore, Grid, domClass) {
    return declare('Brew/content/library/LibraryPage', _Page, {
      pageClass: 'brew-library-page',
      gridClass: 'sage',
      postCreate: function() {
        var grid;
        this.inherited(arguments);
        domClass.add(this.domNode, this.gridClass);
        grid = new Grid({
          store: new BreweryDBStore({
            target: '/beers/'
          }),
          columns: Brew.ui.grid.StructureFactory.structureFor('beers'),
          rowsPerPage: 50,
          pagingTextBox: true
        });
        this.addChild(grid);
        return grid.refresh();
      }
    });
  });

}).call(this);
