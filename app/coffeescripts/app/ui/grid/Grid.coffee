define 'Brew/ui/grid/Grid', [
  'dojo/_base/declare',
  'dgrid/OnDemandGrid',
  'dojox/widget/Standby',
  'dojo/_base/window'

], (declare, OnDemandGrid, Standby, win) ->

  declare 'Brew.ui.grid.Grid', OnDemandGrid,

    postCreate: () ->
      grid = @
      @on ".dgrid-cell.clickable:click", (e) ->
        beerId = grid.row(e).id
        Brew.util.navigation.HashManager.setHash '/beers/' + beerId

      @inherited arguments

    refresh: ->
      @getStandBy().show()
      @inherited arguments

    _processScroll: (evt) ->
      ret = @inherited arguments
      @getStandBy().hide()
      ret

    getStandBy: ->
      if not @standby?
        @standby = new Standby {target: @domNode}
        win.body().appendChild(@standby.domNode)
        @standby.startup()

      @standby
