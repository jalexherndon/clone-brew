define [
  'dojo/_base/declare',
  'dojox/widget/Standby',
  'dojo/_base/lang',
  'dojo/_base/window'

], (declare, Standby, lang, win) ->

  StandbyManager = declare [],
    standby: null

    showStandby: (target) ->
      @_getStandby(target).show()

    hideStandby: () ->
      @standby?.hide()

    _getStandby: (target)->
      if not @standby?
        @standby = new Standby {}
        win.body().appendChild(@standby.domNode)
        @standby.startup()

      @standby.set('target', target)
      @standby

  unless lang.getObject("ui.StandbyManager", false, Brew)?
    lang.setObject "ui.StandbyManager", new StandbyManager(), Brew

  Brew.ui.StandbyManager