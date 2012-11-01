(function() {

  define('Brew/data/Store', ['dojo/_base/declare', 'dojox/data/RailsStore'], function(declare, RailsStore) {
    return declare('Brew.data.Store', RailsStore, {
      getValue: function(item, property, defaultValue) {
        var nested_props, value;
        value = this.inherited(arguments);
        if (!(value != null) && (item != null) && property.indexOf('.' >= 0)) {
          nested_props = property.split('.');
          value = this._getNestedValue(item, nested_props);
        }
        return value;
      },
      _getNestedValue: function(item, nested_props) {
        var i, nested_item, value, _fn, _i, _len;
        if (nested_props.length === 1) {
          if (!dojo.isArray(item)) {
            item = [item];
          }
          value = '';
          _fn = function(i) {
            if (value.length !== 0) {
              value += ', ';
            }
            return value += i[nested_props[0]];
          };
          for (_i = 0, _len = item.length; _i < _len; _i++) {
            i = item[_i];
            _fn(i);
          }
          return value;
        } else {
          nested_item = item[nested_props[0]];
          if (nested_item != null) {
            return this._getNestedValue(nested_item, nested_props.slice(1));
          }
        }
      }
    });
  });

}).call(this);
