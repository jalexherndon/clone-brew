(function() {

  define("Brew/content/detail/beer/BeerPage", ["dojo/_base/declare", "Brew/content/_Page", "dojo/request/xhr", "Brew/content/detail/beer/BeerDetailPane"], function(declare, _Page, xhr, BeerDetailPane) {
    return declare("Brew.content.detail.beer.BeerPage", _Page, {
      beerId: null,
      constructor: function(config) {
        return config.beerId = config != null ? config.id : void 0;
      },
      postCreate: function() {
        var me,
          _this = this;
        this.inherited(arguments);
        me = this;
        return xhr("/beers/" + this.beerId, {
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
