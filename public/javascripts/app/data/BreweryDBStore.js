(function() {

  define('Brew/data/BreweryDBStore', ['dojo/_base/declare', 'dojo/store/JsonRest', 'dojo/_base/lang'], function(declare, JsonRest, lang) {
    return declare('Brew.data.BreweryDBStore', JsonRest, {
      defaultParams: {
        withBreweries: 'Y'
      },
      query: function(query, options) {
        lang.mixin(query, this.defaultParams);
        if ((options.start != null) && options.count === 50) {
          query.p = (options.start / options.count) + 1;
        }
        return this.inherited(arguments);
      }
    });
  });

}).call(this);
