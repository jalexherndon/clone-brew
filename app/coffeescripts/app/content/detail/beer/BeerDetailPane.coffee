define 'Brew/content/detail/beer/BeerDetailPane', [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/dom-style',
  'dojo/query',
  'dojo/_base/window',
  'dojo/NodeList-traverse'

], (declare, _WidgetBase, _TemplatedMixin, domStyle, query, win) ->

  declare 'Brew.content.beer.BeerDetailPane', [_WidgetBase, _TemplatedMixin],
    baseClass: 'beer_detail_pane'

    templateString: "
      <div class=\"${baseClass}\">
        <div class=\"${baseClass}_header\">
          <div class=\"${baseClass}_name\">${beer.name}</div>
          <div class=\"${baseClass}_brewery\" data-dojo-attach-point=\"breweryNode\">${brewery}</div>
        </div>
        <div class=\"${baseClass}_content\">
          <img class=\"${baseClass}_label\" src=\"\" data-dojo-attach-point=\"labelNode\">
          <div class=\"${baseClass}_info\">
            <div class=\"${baseClass}_stats\">${stats}</div>
            <div class=\"${baseClass}_description\">${beer.description}</div>
          </div>
        </div>
      </div>
    "

    beer: null
    label: null
    brewery: null
    stats: null

    detailAttrs: {
      Style: 'style.name'
      Abv: 'abv'
      Ibu: 'ibu'
      Srm: 'srm.name'
      Og: 'og'
      Fg: 'fg'
    }

    constructor: (config) ->
      config.label = config.beer.labels?.medium
      config.beer.description = '' unless config.beer.description
      breweries = config.beer.breweries
      config.brewery = @_getBreweryNameString(breweries) if breweries
      config.stats = @_buildStatsFor config.beer
      @inherited arguments

    _setLabelAttr: (label) ->
      label = "http://www.brewerydb.com/img/beer-tile.png" unless label
      @_set "label", label
      @labelNode.src = label

    _getBreweryNameString: (breweries) ->
      breweries = [breweries] unless dojo.isArray(breweries)
      breweryString = []
      for brewery in breweries
        do (brewery) ->
          breweryString.push brewery.name

      breweryString.join ', '

    _buildStatsFor: (beer) ->
      table = ['<table><tr>']
      for key, attr of @detailAttrs
        do (key, attr) =>
          beerAttr = @_getAttrFromObject(beer, attr)
          return unless beerAttr
          table.push( '<th>' + key + ':</th>')
          table.push( '<td>' + beerAttr + '</td>' )

      table.push '</tr></table>'
      table.join('')

    _getAttrFromObject: (obj, attrs) ->
      return if obj is null
      attrs = attrs.split '.' unless dojo.isArray attrs

      obj = obj[attrs[0]]
      if attrs.length is 1
        obj
      else
        @_getAttrFromObject obj, attrs[1..] if obj

