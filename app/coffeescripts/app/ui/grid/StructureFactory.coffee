define 'Brew/ui/grid/StructureFactory', [
    'dojo/_base/declare'
    'dojo/_base/lang'

], (declare, lang) ->

    factory = declare 'Brew.ui.grid.StructureFactory', null,

        structures:
            default: [{
                    name: 'Name'
                    field: 'name'
                }]

            beers: [{
                    name: 'Name'
                    field: 'name'
                    width: '150px'
                },{
                    name: 'Brewery'
                    field: 'brewery.name'
                    width: '150px'
                },{
                    name: 'Description'
                    field: 'description'
                    width: '400px'
                }]

        structureFor: (modelName) ->
            if @structures[modelName]
                @structures[modelName]
            else
                @structures.default

    lang.getObject 'ui.grid.StructureFactory', true, Brew
    Brew.ui.grid.StructureFactory = new factory()
    Brew.ui.grid.StructureFactory