define 'Brew/ui/grid/Grid', [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dgrid/Grid',
  'dgrid/extensions/Pagination',
  'dgrid/extensions/DijitRegistry'

], (declare, lang, Grid, Pagination, DijitRegistry) ->

  declare 'Brew.ui.grid.Grid', [Grid, Pagination, DijitRegistry],

    showLoadingMask: false

    postCreate: () ->
      @inherited arguments
      @on ".dgrid-cell.clickable:click", (e) =>
        beerId = @row(e).id
        Brew.util.navigation.HashManager.setHash '/beer/detail/' + beerId

    searchFor: (queryString, type) -> 
      @store.target = 'brewery_db/search'
      queryString = queryString.replace(/\s/, "+")
      @query = lang.mixin(@query, {type: type, q: queryString})
      @refresh()
