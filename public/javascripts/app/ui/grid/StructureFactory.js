(function() {

  define('Brew/ui/grid/StructureFactory', ['dojo/_base/declare', 'dojo/_base/lang'], function(declare, lang) {
    var factory;
    factory = declare('Brew.ui.grid.StructureFactory', null, {
      structures: {
        "default": [
          {
            name: 'Name',
            field: 'name'
          }
        ],
        beers: [
          {
            name: ' ',
            field: 'labels',
            width: '70px',
            disableSort: true,
            formatter: function(labels) {
              if ((labels != null ? labels.icon : void 0) != null) {
                return '<img src="' + labels.icon + '" />';
              }
            }
          }, {
            name: 'Name',
            field: 'name',
            width: '150px'
          }, {
            name: 'Brewery',
            field: 'breweries.name',
            disableSort: true,
            width: '150px'
          }, {
            name: 'Style',
            field: 'style',
            sortField: 'styleId',
            width: '150px',
            formatter: function(style) {
              return style != null ? style.name : void 0;
            }
          }, {
            name: 'IBU',
            field: 'ibu',
            width: '50px'
          }, {
            name: 'ABV',
            field: 'abv',
            width: '50px'
          }, {
            name: 'SRM',
            field: 'srmId',
            width: '50px'
          }
        ]
      },
      structureFor: function(modelName) {
        if (this.structures[modelName]) {
          return this.structures[modelName];
        } else {
          return this.structures["default"];
        }
      }
    });
    lang.getObject('ui.grid.StructureFactory', true, Brew);
    Brew.ui.grid.StructureFactory = new factory();
    return Brew.ui.grid.StructureFactory;
  });

}).call(this);
