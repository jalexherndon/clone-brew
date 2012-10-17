(function() {

  define('Brew/data/Store', ['dojo/_base/declare', 'dojox/data/RailsStore'], function(declare, RailsStore) {
    return declare('Brew.data.Store', RailsStore, {
      getValue: function(item, property, defaultValue) {
        var nested_props, value;
        value = this.inherited(arguments);
        if (!value && property.indexOf('.' >= 0)) {
          nested_props = property.split('.');
          value = this._getNestedValue(item, nested_props);
        }
        return value;
      },
      _getNestedValue: function(item, nested_props) {
        if (nested_props.length === 1) {
          return item[nested_props[0]];
        }
        return this._getNestedValue(item[nested_props.splice(0, 1)[0]], nested_props);
      }
    });
  });

}).call(this);
