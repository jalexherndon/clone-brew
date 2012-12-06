(function() {

  define('Brew/ui/grid/StructureFactory', ['dojo/_base/declare', 'dojo/_base/lang'], function(declare, lang) {
    var factory;
    factory = declare('Brew.ui.grid.StructureFactory', null, {
      structures: {
        beers: {
          label: {
            label: ' ',
            get: function(beer) {
              var _ref;
              return (_ref = beer.labels) != null ? _ref.icon : void 0;
            },
            formatter: function(img) {
              if (img != null) {
                return '<img src="' + img + '" />';
              } else {
                return '<img src="http://www.brewerydb.com/img/beer.png" />';
              }
            }
          },
          name: {
            label: 'Name',
            className: 'clickable'
          },
          brewery: {
            label: 'Brewery',
            sortable: false,
            get: function(beer) {
              var brewery, breweryName, _fn, _i, _len, _ref;
              breweryName = [];
              if (beer.breweries != null) {
                _ref = beer.breweries;
                _fn = function(brewery) {
                  return breweryName.push(brewery.name);
                };
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                  brewery = _ref[_i];
                  _fn(brewery);
                }
              }
              if (breweryName.length !== 0) {
                return breweryName.join(', ');
              }
            }
          },
          style: {
            sortable: false,
            label: 'Style',
            get: function(beer) {
              var _ref;
              return (_ref = beer.style) != null ? _ref.name : void 0;
            }
          },
          ibu: 'IBU',
          abv: 'ABV',
          srm: {
            label: 'SRM',
            width: 40,
            sortable: false,
            get: function(beer) {
              var _ref;
              return (_ref = beer.srm) != null ? _ref.name : void 0;
            }
          }
        }
      },
      structureFor: function(modelName) {
        return this.structures[modelName];
      }
    });
    lang.getObject('ui.grid.StructureFactory', true, Brew);
    Brew.ui.grid.StructureFactory = new factory();
    return Brew.ui.grid.StructureFactory;
  });

}).call(this);
