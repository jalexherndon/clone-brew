define [
  'dojo/_base/declare',
  'Brew/ui/listview/_ListView',
  'Brew/data/BreweryDBStore'

], (declare, _ListView, BreweryDBStore) ->

  declare [_ListView],
    getGridConfig: () ->
      store: new BreweryDBStore {target: '/beers'}
      columns: Brew.ui.grid.StructureFactory.structureFor('beers')
      rowsPerPage: 50
      pagingTextBox: true

    getSearchBarConfig: () ->
      searchType: 'beer'
