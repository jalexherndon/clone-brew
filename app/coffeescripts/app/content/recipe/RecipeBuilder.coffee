define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/content/recipe/RecipeInfo',
  'Brew/content/recipe/RecipeIngredientSection',
  'Brew/content/recipe/RecipeNotes',
  'dijit/form/Button',
  'dojo/request',
  'dojo/json',
  'dojo/_base/lang',
  'Brew/ui/StandbyManager',
  'Brew/data/helper/RecipeHelper'

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeIngredientSection, RecipeNotes, Button, request, json, lang, StandbyManager, RecipeHelper) ->
  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-recipe-builder"

    templateString: "
    <div>
      <div class=\"${baseClass}-info\"></div>
      <div class=\"${baseClass}-grains\"></div>
      <div class=\"${baseClass}-hops\"></div>
      <div class=\"${baseClass}-yeasts\"></div>
      <div class=\"${baseClass}-miscellaneous\"></div>
      <div class=\"${baseClass}-notes-and-instructions\"></div>
      <div class=\"${baseClass}-create-recipe\"></div>
    </div>
    "

    beer: null
    recipe: null

    postCreate: () ->
      @_info = new RecipeInfo({
        beer: @beer
        recipe: @recipe
      }, query("." + @baseClass + "-info", @domNode)[0])

      @_sections = [
        new RecipeIngredientSection({
          title: 'Grains & Extracts'
          ingredient_category: 'Fermentable'
          recipe: @recipe
        }, query("." + @baseClass + "-grains", @domNode)[0]),

        new RecipeIngredientSection({
          title: 'Hops'
          ingredient_category: 'Hops'
          has_time: true
          recipe: @recipe
        }, query("." + @baseClass + "-hops", @domNode)[0]),

        new RecipeIngredientSection({
          title: 'Yeasts'
          ingredient_category: 'Yeast'
          recipe: @recipe
        }, query("." + @baseClass + "-yeasts", @domNode)[0]),

        new RecipeIngredientSection({
          title: 'Miscellaneous'
          ingredient_category: 'Miscellaneous'
          recipe: @recipe
        }, query("." + @baseClass + "-miscellaneous", @domNode)[0])
      ]

      @_notes = new RecipeNotes({
        recipe: @recipe
      }, query("." + @baseClass + "-notes-and-instructions", @domNode)[0])

      if RecipeHelper.isEditable(@recipe)
        new Button({
          label: "#{(if @recipe? then "Save" else "Create")} Recipe"
          class: "#{@baseClass}-create-recipe"
          onClick: () =>
            return unless @_info.validate()
            StandbyManager.showStandby(@domNode)
            @_saveRecipe()
        }, query(".#{@baseClass}-create-recipe", @domNode)[0])

    _saveRecipe: () ->
      data = @get("value")
      request[if data.id? then "put" else "post"]('/recipes/' + (if data.id? then data.id else ""),
        handleAs: 'json'
        data:
          recipe: json.stringify(data)
      ).then( (resp) =>
        @set('value', resp)
        StandbyManager.hideStandby()
        @emit('brew-recipe-after-create', resp)
      )

    _getValueAttr: () ->
      recipe = lang.mixin({beer_id: @beer.id}, @_info.get('value'), @_notes.get('value'))
      lang.mixin(recipe, {id: @recipe.id}) if @recipe?

      recipe.ingredient_details = []
      for section in @_sections
        recipe.ingredient_details.push.apply(recipe.ingredient_details, section.get('value'))

      recipe

    _setValueAttr: (value) ->
      @_notes.set('value', if value? then value.notes else value)
      delete value?.notes
      
      section.set('value', if value? then value.ingredient_details else value) for section in @_sections
      delete value?.ingredient_details

      @_info.set('value', value)
