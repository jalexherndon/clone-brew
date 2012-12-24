define "Brew/content/detail/beer/BeerPage", [
  "dojo/_base/declare",
  "Brew/contnent/_Page",
  "dojo/request/xhr",
  "Brew/content/detail/beer/BeerDetailPane"

], (declare, _Page, xhr, BeerDetailPane) ->

  declare "Brew.content.detail.beer.BeerPage", _Page,
    pageAction: null

    postCreate: (config) ->
      @inherited arguments
      me = this

      xhr("/beers/" + @pageAction, {
        handleAs: "json"
        query: {
          withBreweries: 'Y'
        }
      }).then (beer) =>
        me.addChild new BeerDetailPane(beer: beer)