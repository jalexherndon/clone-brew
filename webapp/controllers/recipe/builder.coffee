angular.module('clonebrews').controller 'RecipeBuilderController', [
  '$scope'
  '$cookieStore'
  '$location'
  'RecipeService'
  'IngredientService'

  ($scope, $cookieStore, $location, RecipeService, IngredientService) ->
    recipeFields = [
      'name'
      'brew_method'
      'batch_size'
      'boil_size'
      'boil_time'
      'efficiency'
      'ingredient_details'
      'mash_steps'
      'notes'
      'source'
      ]

    $scope.ingredients = IngredientService.query()

    $scope.units =
      'cups': 0
      'g'   : 1
      'kg'  : 2
      'lbs' : 3
      'oz'  : 4
      '%'   : 5
      'pkg' : 6
    $scope.addIngredientDetail = () ->
      $scope.ingredient_details ?= []
      $scope.ingredient_details.push {}
    $scope.removeIngredientDetail = (detail) ->
      $scope.ingredient_details = _.without $scope.ingredient_details, detail

    $scope.step_types =
      'Decoction'   : 0
      'Fly Sparge'  : 1
      'Infusion'    : 2
      'Sparge'      : 3
      'Temperature' : 4
    $scope.addMashStep = () ->
      $scope.mash_steps ?= []
      $scope.mash_steps.push {}
    $scope.removeMashStep = (step) ->
      $scope.mash_steps = _.without $scope.mash_steps, step

    $scope.createRecipe = () ->
      $scope.beer.then (beer) ->
        recipe_data = _.pick($scope, recipeFields)
        recipe_data.beer_id = beer.id
        RecipeService.save(recipe_data)
        .then (response) =>
          removeStoredRecipe()
          $location.search 'building', false
        , (error) =>
          error = error

    $scope.discardRecipe = () ->
      removeStoredRecipe()
      $location.search 'building', false

    $scope.storeAndExit = () ->
      storeRecipe()
      $location.search 'building', false

    storeRecipe = () ->
      recipeData = _.pick $scope, recipeFields

      $scope.beer.then (beer) ->
        $cookieStore.put "recipe_builder_#{beer.id}", recipeData

    removeStoredRecipe = () ->
      $scope.beer.then (beer) ->
        $cookieStore.remove "recipe_builder_#{beer.id}"

    if recipe?
      _.extend $scope, recipe
    else
      $scope.beer.then (beer) ->
        recipeData = $cookieStore.get("recipe_builder_#{beer.id}") || {}
        _.extend $scope, recipeData

      $scope.$on '$destroy', storeRecipe
      $(window).unload storeRecipe
]