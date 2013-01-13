(function() {

  define('Brew/content/detail/beer/BeerDetailPane', ['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/dom-style', 'dojo/_base/window', 'dojo/NodeList-traverse'], function(declare, _WidgetBase, _TemplatedMixin, domStyle, win) {
    return declare('Brew.content.beer.BeerDetailPane', [_WidgetBase, _TemplatedMixin], {
      baseClass: 'beer_detail_pane',
      templateString: "      <div class=\"${baseClass}\">        <div class=\"${baseClass}_header\">          <div class=\"${baseClass}_name\">${beer.name}</div>          <div class=\"${baseClass}_brewery\" data-dojo-attach-point=\"breweryNode\">${brewery}</div>        </div>        <div class=\"${baseClass}_content\">          <img class=\"${baseClass}_label\" src=\"\" data-dojo-attach-point=\"labelNode\">          <div class=\"${baseClass}_info\">            <div class=\"${baseClass}_stats\">${stats}</div>            <div class=\"${baseClass}_description\">${beer.description}</div>          </div>        </div>      </div>    ",
      beer: null,
      label: null,
      brewery: null,
      stats: null,
      detailAttrs: {
        Style: 'style.name',
        Abv: 'abv',
        Ibu: 'ibu',
        Srm: 'srm.name',
        Og: 'og',
        Fg: 'fg'
      },
      constructor: function(config) {
        var breweries, _ref;
        config.label = (_ref = config.beer.labels) != null ? _ref.medium : void 0;
        if (!config.beer.description) {
          config.beer.description = '';
        }
        breweries = config.beer.breweries;
        if (breweries) {
          config.brewery = this._getBreweryNameString(breweries);
        }
        config.stats = this._buildStatsFor(config.beer);
        return this.inherited(arguments);
      },
      _setLabelAttr: function(label) {
        if (!label) {
          label = "http://www.brewerydb.com/img/beer-tile.png";
        }
        this._set("label", label);
        return this.labelNode.src = label;
      },
      _getBreweryNameString: function(breweries) {
        var brewery, breweryString, _fn, _i, _len;
        if (!dojo.isArray(breweries)) {
          breweries = [breweries];
        }
        breweryString = [];
        _fn = function(brewery) {
          return breweryString.push(brewery.name);
        };
        for (_i = 0, _len = breweries.length; _i < _len; _i++) {
          brewery = breweries[_i];
          _fn(brewery);
        }
        return breweryString.join(', ');
      },
      _buildStatsFor: function(beer) {
        var attr, key, table, _fn, _ref,
          _this = this;
        table = ['<table><tr>'];
        _ref = this.detailAttrs;
        _fn = function(key, attr) {
          var beerAttr;
          beerAttr = _this._getAttrFromObject(beer, attr);
          if (!beerAttr) {
            return;
          }
          table.push('<th>' + key + ':</th>');
          return table.push('<td>' + beerAttr + '</td>');
        };
        for (key in _ref) {
          attr = _ref[key];
          _fn(key, attr);
        }
        table.push('</tr></table>');
        return table.join('');
      },
      _getAttrFromObject: function(obj, attrs) {
        if (obj === null) {
          return;
        }
        if (!dojo.isArray(attrs)) {
          attrs = attrs.split('.');
        }
        obj = obj[attrs[0]];
        if (attrs.length === 1) {
          return obj;
        } else {
          if (obj) {
            return this._getAttrFromObject(obj, attrs.slice(1));
          }
        }
      }
    });
  });

}).call(this);
