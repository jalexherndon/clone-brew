(function() {

  define('Brew/content/library/LibraryPage', ['dojo/_base/declare', 'Brew/content/_Page', 'dijit/layout/TabContainer', 'Brew/content/library/BeerListView'], function(declare, _Page, TabContainer, BeerListView) {
    return declare('Brew.content.library.LibraryPage', _Page, {
      pageClass: 'brew-library-page',
      postCreate: function() {
        var tabCont;
        this.inherited(arguments);
        tabCont = new TabContainer({
          style: "width: 100%; height: 100%;"
        });
        tabCont.addChild(new BeerListView({
          title: 'Beers'
        }));
        return this.addChild(tabCont);
      }
    });
  });

}).call(this);
