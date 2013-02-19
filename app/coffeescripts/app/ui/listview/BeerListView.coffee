define [
  'dojo/_base/declare',
  'Brew/ui/listview/_ListView',
  'Brew/data/BreweryDBStore',
  'Brew/ui/grid/Grid',
  'Brew/util/navigation/HashManager'

], (declare, _ListView, BreweryDBStore, Grid, HashManager) ->

  declare [_ListView],
    postCreate: () ->
      @inherited(arguments)
      @grid.on ".dgrid-cell.dgrid-column-name:click", (e) =>
        beerId = @grid.row(e).id
        HashManager.setHash '/beer/detail/' + beerId


    getGrid: (container) ->
      new Grid({
        store: new BreweryDBStore {target: '/beers'}
        columns: Brew.ui.grid.StructureFactory.structureFor('beers')
        rowsPerPage: 50
        pagingTextBox: true
      }, container)

    getSearchBarConfig: () ->
      searchType: 'beer'
