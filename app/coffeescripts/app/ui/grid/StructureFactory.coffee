define 'Brew/ui/grid/StructureFactory', [
    'dojo/_base/declare'
    'dojo/_base/lang'

], (declare, lang) ->

    factory = declare 'Brew.ui.grid.StructureFactory', null,

        structures:
          beers: {
            label:
              label: ' '
              get: (beer) ->
                beer.labels?.icon
              formatter: (img) ->
                if img?
                  '<img src="' + img + '" />'
                else
                  '<img src="http://www.brewerydb.com/img/beer.png" />'

            name: 
              label: 'Name'
              className: 'clickable'

            brewery:
              label: 'Brewery'
              get: (beer) ->
                breweryName = []
                if beer.breweries?
                  for brewery in beer.breweries
                    do (brewery) ->
                      breweryName.push brewery.name
                return breweryName.join ', ' unless breweryName.length is 0

            style:
              label: 'Style'
              get: (beer) ->
                return beer.style?.name

            ibu: 'IBU'
            abv: 'ABV'
            srm:
              label: 'SRM'
              width: 40
              get: (beer) ->
                beer.srm?.name
          }

        structureFor: (modelName) ->
          @structures[modelName]
                

    lang.getObject 'ui.grid.StructureFactory', true, Brew
    Brew.ui.grid.StructureFactory = new factory()
    Brew.ui.grid.StructureFactory
