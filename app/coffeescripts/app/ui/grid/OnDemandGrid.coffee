define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dgrid/OnDemandGrid',
  'dgrid/extensions/DijitRegistry',
  'dojo/dom-class'

], (declare, lang, OnDemandGrid, DijitRegistry, domClass) ->

  declare [OnDemandGrid, DijitRegistry],
    postCreate: () ->
      @inherited(arguments)
      domClass.add(@domNode, "brew-on-demand-grid")
      