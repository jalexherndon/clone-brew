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
            name: 'Name',
            field: 'name',
            width: '150px'
          }, {
            name: 'Brewery',
            field: 'brewery.name',
            width: '150px'
          }, {
            name: 'Description',
            field: 'description',
            width: '400px'
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
