define 'Brew/content/library/LibraryPage', [
    'dojo/_base/declare',
    'Brew/ui/_Page',
    'Brew/data/Store',
    'dojox/grid/DataGrid',
    'dojo/query'

], (declare, _Page, BrewStore, DataGrid, query) ->

    declare 'Brew.content.library.LibraryPage', _Page,

        postCreate: ->
            @inherited arguments
            
            grid = new DataGrid {
                id: 'brew-grid'
                store: new BrewStore(target: '/beers/')
                cellOverClass: ''
                structure: Brew.ui.grid.StructureFactory.structureFor('beers')
                autoWidth: true
                autoHeight: true
            }

            @addChild grid
