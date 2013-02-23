define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dgrid/OnDemandGrid',
  'dgrid/extensions/DijitRegistry',
  'dojo/dom-class',
  'put-selector/put'

], (declare, lang, OnDemandGrid, DijitRegistry, domClass, put) ->

  declare [OnDemandGrid, DijitRegistry],
    postCreate: () ->
      @inherited(arguments)
      domClass.add(@domNode, "brew-on-demand-grid")

    renderQuery: (query, preloadNode, options) ->
      results = @inherited(arguments)
      results.then (res) =>
        if res.length is 0
          @noDataNode = put(@contentNode, "div.dgrid-no-data");
          @noDataNode.innerHTML = @noDataMessage;

      results

      