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
      @on ".dgrid-cell.clickable:click", (e) =>
        beerId = @row(e).id
        Brew.util.navigation.HashManager.setHash '/beer/detail/' + beerId

      @inherited arguments

    gotoPage: ->
      @getStandBy().show()
      @inherited arguments

    searchFor: (queryString, type) -> 
      @store.target = 'brewery_db/search'
      @query = lang.mixin(@query, {type: type, q: queryString})
      @.refresh()

    _updateNavigation: ->
      ret = @inherited arguments
      @getStandBy().hide()
      ret

    getStandBy: ->
      if not @standby?
        @standby = new Standby {target: @domNode}
        win.body().appendChild(@standby.domNode)
        @standby.startup()

      @standby
