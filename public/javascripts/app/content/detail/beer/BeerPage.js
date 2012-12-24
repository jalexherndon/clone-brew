(function() {

  define("Brew/content/detail/beer/BeerPage", ["dojo/_base/declare", "Brew/contnent/_Page", "dojo/request/xhr", "Brew/content/detail/beer/BeerDetailPane"], function(declare, _Page, xhr, BeerDetailPane) {
    return declare("Brew.content.detail.beer.BeerPage", _Page, {
      pageAction: null,
      postCreate: function(config) {
        var me,
          _this = this;
        this.inherited(arguments);
        me = this;
        return xhr("/beers/" + this.pageAction, {
          handleAs: "json",
          query: {
            withBreweries: 'Y'
          }
        }).then(function(beer) {
          return me.addChild(new BeerDetailPane({
            beer: beer
          }));
        });
      }
    });
  });

}).call(this);
