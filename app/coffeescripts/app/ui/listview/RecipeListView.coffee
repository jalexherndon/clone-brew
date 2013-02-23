define [
  'dojo/_base/declare',
  'Brew/ui/listview/_ListView',
  'Brew/data/Store',
  'Brew/ui/grid/OnDemandGrid',
  'dojo/Evented'

], (declare, _ListView, Store, OnDemandGrid, Evented) ->

  declare [_ListView],
    getGrid: (container) ->
      new OnDemandGrid({
        store: new Store({target: '/recipes'})
        columns: Brew.ui.grid.StructureFactory.structureFor('recipes')
        rowsPerPage: 50
        pagingTextBox: true
        noDataMessage: "No one has added a recipe for #{@beer.name} yet.<br /><p class=\"clickable link add-recipe\">Add one now!</p>"
        loadingMessage: "Loading recipes for #{@beer.name}..."
        query:
          beer_id: @beer.id
      }, container)

    getSearchBarConfig: () ->
      searchType: 'recipe'
