define 'Brew/content/library/BeerListView', [
  'dojo/_base/declare',
  'Brew/content/library/_ListView',
  'Brew/data/BreweryDBStore'

], (declare, _ListView, BreweryDBStore) ->

  declare 'Brew.content.library.BeerListView', _ListView,
    getGridConfig: () ->
      store: new BreweryDBStore {target: '/beers'}
      columns: Brew.ui.grid.StructureFactory.structureFor('beers')
      rowsPerPage: 50
      pagingTextBox: true

    getSearchBarConfig: () ->
      searchType: 'beer'
