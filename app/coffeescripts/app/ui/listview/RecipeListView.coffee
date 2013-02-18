define [
  'dojo/_base/declare',
  'Brew/ui/listview/_ListView',
  'Brew/data/BreweryDBStore'

], (declare, _ListView, BreweryDBStore) ->

  declare [_ListView],
    getGridConfig: () ->
      store: new BreweryDBStore({target: '/recipes'})
      columns: Brew.ui.grid.StructureFactory.structureFor('recipes')
      rowsPerPage: 50
      pagingTextBox: true
      noDataMessage: "No one has added a recipe for #{@beer.name} yet.<br /><p class=\"clickable link\">Add one now!</p>"
      loadingMessage: "Loading recipes for #{@beer.name}..."
      query:
        beer_id: @beer.id

    getSearchBarConfig: () ->
      searchType: 'recipe'
