(function() {

  define('Brew/data/BreweryDBStore', ['dojo/_base/declare', 'dojo/store/JsonRest', 'dojo/Evented', 'dojo/request/xhr', 'dojo/_base/lang'], function(declare, JsonRest, Evented, xhr, lang) {
    var scrubPagingOptions;
    scrubPagingOptions = function(query, options) {
      if ((options.start != null) && options.count === 50) {
        query.p = (options.start / options.count) + 1;
        delete options.start;
        return delete options.count;
      }
    };
    return declare('Brew.data.BreweryDBStore', [JsonRest, Evented], {
      defaultParams: {
        withBreweries: 'Y'
      },
      searchTarget: "/brewery_db/search",
      defaultTarget: null,
      constructor: function(config) {
        this.defaultTarget = config.target;
        return this.inherited(arguments);
      },
      query: function(query, options) {
        var results,
          _this = this;
        if (options == null) {
          options = {};
        }
        lang.mixin(query, this.defaultParams);
        if (options.isSearch) {
          this.target = this.searchTarget;
        } else {
          this.target = this.defaultTarget;
        }
        scrubPagingOptions(query, options);
        this.emit("beforequery");
        results = this.inherited(arguments);
        results.then(function() {
          return _this.emit("load");
        });
        return results;
      }
    });
  });

}).call(this);
