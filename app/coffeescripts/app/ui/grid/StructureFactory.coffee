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
                  name: ' '
                  field: 'labels'
                  width: '70px'
                  disableSort: true
                  formatter: (labels) ->
                    if labels?.icon?
                      '<img src="' + labels.icon + '" />'
                },{
                    name: 'Name'
                    field: 'name'
                    width: '150px'
                },{
                    name: 'Brewery'
                    field: 'breweries.name'
                    disableSort: true
                    width: '150px'
                },{
                    name: 'Style'
                    field: 'style'
                    sortField: 'styleId'
                    width: '150px'
                    formatter: (style) ->
                      style?.name
                },{
                    name: 'IBU'
                    field: 'ibu'
                    width: '50px'
                },{
                    name: 'ABV'
                    field: 'abv'
                    width: '50px'
                },{
                    name: 'SRM'
                    field: 'srmId'
                    width: '50px'
                }]

        structureFor: (modelName) ->
            if @structures[modelName]
                @structures[modelName]
            else
                @structures.default

    lang.getObject 'ui.grid.StructureFactory', true, Brew
    Brew.ui.grid.StructureFactory = new factory()
    Brew.ui.grid.StructureFactory