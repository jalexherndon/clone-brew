define 'Brew/content/library/LibraryPage', [
  'dojo/_base/declare',
  'Brew/ui/_Page',
  'dojo/store/JsonRest',
  'Brew/data/BreweryDBStore',
  'Brew/ui/grid/Grid',
  'dojo/dom-class'

  ], (declare, _Page, JsonRest, BreweryDBStore, Grid, domClass) ->

    declare 'Brew/content/library/LibraryPage', _Page,

    pageClass: 'brew-library-page'
    gridClass: 'sage'

    postCreate: ->
      @inherited arguments

      domClass.add @domNode, @gridClass
      grid = new Grid
        store: new BreweryDBStore {target: '/beers/'}
        columns: Brew.ui.grid.StructureFactory.structureFor('beers')
        rowsPerPage: 50

      @addChild grid
      grid.refresh()
