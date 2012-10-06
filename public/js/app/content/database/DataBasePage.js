(function() {
    define('Brew/content/database/DataBasePage', [
        'dojo/_base/declare',
        'Brew/ui/_Page',
        'dojox/data/RailsStore',
        'dojox/grid/DataGrid',
        'dojo/query'
    ], function(declare, _Page, RailsStore, DataGrid, query) {
        return declare('Brew.content.admin.AdminPage', _Page, {

            postCreate: function() {
                this.inherited(arguments);

                var store = new RailsStore({
                        target: '/beers/'
                    }),
                    layout = [
                      { name: 'Name', field: 'name', width: '100px'},
                      { name: 'Brewery', field: 'brewery', width: '125px', formatter: this._nameFormatter},
                      { name: 'Description', field: 'description', width: '400px'}
                    ],
                    grid = new DataGrid({
                        id: 'brew-grid',
                        store: store,
                        structure: layout,
                        autoWidth: true,
                        autoHeight: true
                    });

                this.addChild(grid);
                grid.startup();
            },

            _nameFormatter: function(value, rowIdx) {
                return value.name;
            }
        });
    });
})();