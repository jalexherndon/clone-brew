define 'Brew/ui/_Page', [
  'dojo/_base/declare',
  'dijit/layout/ContentPane',
  'dojo/dom-class',
  'dojo/topic'

], (declare, ContentPane, domClass, topic) ->

  declare 'Brew.ui._Page', ContentPane,
    region: 'center'
    pageClass: null

    postCreate: ->
      @inherited arguments
      domClass.add @domNode, 'brew-page'
      domClass.add(@domNode, @pageClass) if @pageClass?

    onShow: ->
      topic.publish Brew.util.Messages.PAGE_LOAD
