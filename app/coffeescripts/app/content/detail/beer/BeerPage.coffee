define "Brew/content/detail/beer/BeerPage", [
  "dojo/_base/declare",
  "Brew/content/_Page",
  "dojo/request/xhr",
  "Brew/content/detail/beer/BeerDetailPane"

], (declare, _Page, xhr, BeerDetailPane) ->

  declare "Brew.content.detail.beer.BeerPage", _Page,
    beerId: null

    constructor: (config) ->
      config.beerId = config?.id

    postCreate: () ->
      @inherited arguments
      me = this

      xhr("/beers/" + @beerId, {
        handleAs: "json"
        query: {
          withBreweries: 'Y'
        }
      }).then (beer) =>
        me.addChild new BeerDetailPane(beer: beer)