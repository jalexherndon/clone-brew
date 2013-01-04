define 'Brew/ui/grid/Grid', [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dgrid/Grid',
  'dgrid/extensions/Pagination',
  'dgrid/extensions/DijitRegistry',
  'dojox/widget/Standby',
  'dojo/_base/window'

], (declare, lang, Grid, Pagination, DijitRegistry, Standby, win) ->

  declare 'Brew.ui.grid.Grid', [Grid, Pagination, DijitRegistry],

    postCreate: () ->
      @inherited arguments
      @on ".dgrid-cell.clickable:click", (e) =>
        beerId = @row(e).id
        Brew.util.navigation.HashManager.setHash '/beer/detail/' + beerId

      @store?.on "beforequery", () =>
        @getStandBy().show()

      @store?.on "load", () =>
        @getStandBy().hide()

    searchFor: (queryString, type) -> 
      @store.target = 'brewery_db/search'
      queryString = queryString.replace(/\s/, "+")
      @query = lang.mixin(@query, {type: type, q: queryString})
      @refresh()

    getStandBy: ->
      if not @standby?
        @standby = new Standby {target: @domNode}
        win.body().appendChild(@standby.domNode)
        @standby.startup()

      @standby
