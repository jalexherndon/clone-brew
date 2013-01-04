(function() {

  define('Brew/data/BreweryDBStore', ['dojo/_base/declare', 'dojo/store/JsonRest', 'dojo/Evented', 'dojo/when', 'dojo/_base/lang'], function(declare, JsonRest, Evented, When, lang) {
    return declare('Brew.data.BreweryDBStore', [JsonRest, Evented], {
      defaultParams: {
        withBreweries: 'Y'
      },
      query: function(query, options) {
        var results,
          _this = this;
        if (options == null) {
          options = {};
        }
        lang.mixin(query, this.defaultParams);
        if ((options.start != null) && options.count === 50) {
          query.p = (options.start / options.count) + 1;
          delete options.start;
          delete options.count;
        }
        this.emit("beforequery");
        results = this.inherited(arguments);
        results.then(function(total) {
          return _this.emit("load");
        });
        return results;
      }
    });
  });

}).call(this);
