define "Brew/content/detail/beer/BeerPage", [
  "dojo/_base/declare",
  "Brew/content/_Page",
  "dojo/request/xhr",
  "Brew/content/detail/beer/BeerDetailPane",
  "Brew/content/recipe/RecipeBuilder"

], (declare, _Page, xhr, BeerDetailPane, RecipeBuilder) ->

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
        me.addChild new RecipeBuilder(beer: beer)