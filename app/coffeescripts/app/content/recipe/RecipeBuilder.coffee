define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/content/recipe/RecipeInfo',
  'Brew/content/recipe/RecipeBuilderSection',
  'dijit/form/Button',
  'dojo/request',
  'dojo/json'

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeBuilderSection, Button, request, json) ->
  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-recipe-builder"

    templateString: "
    <div>
      <div class=\"${baseClass}-title\">New Recipe</div>
      <div class=\"${baseClass}-info\"></div>
      <div class=\"${baseClass}-grains\"></div>
      <div class=\"${baseClass}-hops\"></div>
      <div class=\"${baseClass}-yeasts\"></div>
      <div class=\"${baseClass}-miscellaneous\"></div>
      <div class=\"${baseClass}-create-recipe\"></div>
    </div>
    "

    beer: null

    postCreate: () ->
      @_info = new RecipeInfo({}, query("." + @baseClass + "-info", @domNode)[0])

      @_sections = [
        new RecipeBuilderSection({
          title: 'Grains & Extracts'
          ingredient_category: 'Fermentable'
        }, query("." + @baseClass + "-grains", @domNode)[0]),

        new RecipeBuilderSection({
          title: 'Hops'
          ingredient_category: 'Hops'
          has_time: true
        }, query("." + @baseClass + "-hops", @domNode)[0]),

        new RecipeBuilderSection({
          title: 'Yeasts'
          ingredient_category: 'Yeast'
        }, query("." + @baseClass + "-yeasts", @domNode)[0]),

        new RecipeBuilderSection({
          title: 'Miscellaneous'
          ingredient_category: 'Miscellaneous'
        }, query("." + @baseClass + "-miscellaneous", @domNode)[0])
      ]

      new Button({
        label: "Create Recipe"
        class: "#{@baseClass}-create-recipe"
        onClick: () =>
          @_createRecipe()
      }, query(".#{@baseClass}-create-recipe", @domNode)[0])

    _createRecipe: () ->
      request.post('/recipes',
        handleAs: 'json'
        data:
          recipe: json.stringify(@_gatherRecipeData())
      ).then((resp)=>

      )

    _gatherRecipeData: () ->
      recipe = @_info.get('value')
      recipe.beer_id = @beer.id
      recipe.ingredient_details = []

      for section in @_sections
        recipe.ingredient_details.push.apply(recipe.ingredient_details, section.get('value'))

      recipe

