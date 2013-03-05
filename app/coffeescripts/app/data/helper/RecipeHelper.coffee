define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dojo/request/xhr',
  'dojo/_base/array',
  'dojo/Deferred',
  'Brew/auth/LocalProvider'

], (declare, lang, xhr, Arrays, Deferred, LocalProvider) ->

  helper = declare [],

    brew_methods: [
      "All Grain",
      "Extract",
      "Partial Mash"
    ]
    step_types: [
      'Decoction',
      'Fly Sparge',
      'Infusion',
      'Sparge',
      'Temperature'
    ]


    constructor: (config) ->
      @categories = xhr.get("/ingredient_categories", {
          handleAs: 'json'
          query:
            order: 'name'
        })

    getBrewMethodName: (recipe) ->
      @brew_methods[recipe?.brew_method]

    getMashStepTypeName: (mash_step) ->
      @step_types[mash_step?.step_type]

    isEditable: (recipe) ->
      if recipe?
        recipe.user.id is LocalProvider.getCurrentUser().id
      else
        true

    getDetailsForCategory: (recipe, reference_category_name) ->
      reference_category_name = reference_category_name.name if lang.isObject(reference_category_name)
      deffered = new Deferred()
      ret = []

      @categories.then (categories) =>
        for detail in recipe.ingredient_details
          do (detail) =>
            if @_detailIsWithinCategory(detail.ingredient.ingredient_category, reference_category_name, categories)
              ret.push detail

        deffered.resolve(ret)

      deffered

    _detailIsWithinCategory: (detail_category, reference_category_name, categories) ->
      return false unless detail_category?
      return true if detail_category.name is reference_category_name

      detail_category = @_findCategoryByName(categories, detail_category.name).parent_ingredient_category
      return @_detailIsWithinCategory(detail_category, reference_category_name, categories)

    _findCategoryByName: (categories, name) ->
      return null if categories.length == 0

      mid = Math.floor(categories.length / 2)
      if categories[mid].name == name
        return categories[mid]
      else if name > categories[mid].name
        return @_findCategoryByName(categories[(mid + 1) .. (categories.length)], name)
      else
        return @_findCategoryByName(categories[0 .. (mid - 1)], name)


  unless lang.getObject("data.helper.RecipeHelper", false, Brew)?
    lang.setObject("data.helper.RecipeHelper", new helper(), Brew)

  Brew.data.helper.RecipeHelper
