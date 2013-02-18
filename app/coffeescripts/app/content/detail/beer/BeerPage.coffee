define "Brew/content/detail/beer/BeerPage", [
  "dojo/_base/declare",
  "Brew/content/_Page",
  "dojo/request/xhr",
  "Brew/content/detail/beer/BeerDetailPane",
  "Brew/content/recipe/RecipePanel"

], (declare, _Page, xhr, BeerDetailPane, RecipePanel) ->

  declare "Brew.content.detail.beer.BeerPage", _Page,
    beerId: null

    constructor: (config) ->
      config.beerId = config?.id

    postCreate: () ->
      @inherited arguments

      xhr("/beers/" + @beerId, {
        handleAs: "json"
        query: {
          withBreweries: 'Y'
        }
      }).then (beer) =>
        @addChild new BeerDetailPane(beer: beer)
        @addChild new RecipePanel(beer: beer)
