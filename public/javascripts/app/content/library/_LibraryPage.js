(function() {

  define('Brew/content/library/_LibraryPage', ['dojo/_base/declare', 'Brew/ui/_Page', 'dojo/dom-class'], function(declare, _Page, domClass) {
    return declare('Brew.content.library._LibraryPage', _Page, {
      pageClass: 'brew-library-page',
      gridClass: 'sage',
      postCreate: function() {
        var grid;
        this.inherited(arguments);
        domClass.add(this.domNode, this.gridClass);
        grid = this.getGrid();
        this.addChild(grid);
        return grid.refresh();
      },
      getGrid: function() {
        throw new Error(Brew.util.Errors.UNIMPLEMENTED_METHOD);
      },
      getFilterPane: function() {
        throw new Error(Brew.util.Errors.UNIMPLEMENTED_METHOD);
      }
    });
  });

}).call(this);
