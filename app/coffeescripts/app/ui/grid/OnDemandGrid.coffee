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
      if lang.isArray(results)
        @_renderNoDataMessage() if results.length is 0
      else
        results.then (res) =>
          @_renderNoDataMessage() if res.length is 0

      results

    _renderNoDataMessage: () ->
      @noDataNode = put(@contentNode, "div.dgrid-no-data");
      @noDataNode.innerHTML = @noDataMessage;

      