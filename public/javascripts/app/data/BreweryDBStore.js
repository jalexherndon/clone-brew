(function() {

  define('Brew/data/BreweryDBStore', ['dojo/_base/declare', 'Brew/data/Store', 'dojo/_base/lang'], function(declare, BrewStore, lang) {
    return declare('Brew.data.BreweryDBStore', BrewStore, {
      defaultParams: {
        withBreweries: 'Y'
      },
      fetch: function(args) {
        var item, _ref;
        if ((_ref = args.query) == null) {
          args.query = {};
        }
        lang.mixin(args.query, this.defaultParams);
        if (args.sort) {
          item = args.sort[0];
          lang.mixin(args.query, {
            order: item.attribute,
            sort: item.descending ? 'DESC' : 'ASC'
          });
          delete args.sort;
        }
        return this.inherited(arguments);
      }
    });
  });

}).call(this);
