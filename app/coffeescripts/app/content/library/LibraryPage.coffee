define "Brew/content/library/LibraryPage", [
    "dojo/_base/declare",
    "Brew/ui/_Page",
    "dojox/data/RailsStore",
    "dojox/grid/DataGrid",
    "dojo/query"

], (declare, _Page, RailsStore, DataGrid, query) ->

    declare "Brew.content.library.LibraryPage", _Page,
    
        postCreate: ->
            @inherited arguments
            
            grid = new DataGrid {
                id: "brew-grid"
                store: new RailsStore(target: "/beers/")
                structure: [{
                    name: "Name"
                    field: "name"
                    width: "100px"
                },{
                    name: "Brewery"
                    field: "brewery"
                    width: "125px"
                    formatter: @_nameFormatter
                },{
                    name: "Description"
                    field: "description"
                    width: "400px"
                }]
                autoWidth: true
                autoHeight: true
            }
            
            @addChild grid

        _nameFormatter: (value, rowIdx) ->
            value.name
