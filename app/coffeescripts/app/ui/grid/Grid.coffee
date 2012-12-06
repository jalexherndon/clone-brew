define 'Brew/ui/grid/Grid', [
  'dojo/_base/declare',
  'dgrid/Grid',
  'dgrid/extensions/Pagination',
  'dojox/widget/Standby',
  'dojo/_base/window'

], (declare, Grid, Pagination, Standby, win) ->

  declare 'Brew.ui.grid.Grid', [Grid, Pagination],

    postCreate: () ->
      grid = @
      @on ".dgrid-cell.clickable:click", (e) ->
        beerId = grid.row(e).id
        Brew.util.navigation.HashManager.setHash '/beers/' + beerId
      @on "dgrid-error", (error, b, c) ->
        debugger

      @inherited arguments

    gotoPage: ->
      @getStandBy().show()
      @inherited arguments

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
