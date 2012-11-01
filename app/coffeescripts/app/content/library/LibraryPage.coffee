define 'Brew/content/library/LibraryPage', [
  'dojo/_base/declare',
  'Brew/ui/_Page',
  'Brew/data/BreweryDBStore',
  'Brew/ui/grid/Grid'

  ], (declare, _Page, BreweryDBStore, DataGrid) ->

    declare 'Brew/content/library/LibraryPage', _Page,

    postCreate: ->
      @inherited arguments

      @addChild new DataGrid {
        id: 'brew-grid'
        store: new BreweryDBStore {target: '/beers/'}
        rowsPerPage: 50
        cellOverClass: ''
        fetchText: 'fetch'
        structure: Brew.ui.grid.StructureFactory.structureFor('beers')
        autoWidth: true
        autoHeight: true
      }
