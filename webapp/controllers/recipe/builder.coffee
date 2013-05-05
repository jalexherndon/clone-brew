angular.module('clonebrews').controller 'RecipeBuilderController', [
  '$scope'
  '$cookieStore'
  '$location'
  'RecipeService'

  ($scope, $cookieStore, $location, RecipeService) ->
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

    $scope.step_types =
      'Decoction'   : 0
      'Fly Sparge'  : 1
      'Infusion'    : 2
      'Sparge'      : 3
      'Temperature' : 4
    $scope.addMashStep = () ->
      $scope.mash_steps ?= []
      $scope.mash_steps.push {}

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
      debugger
      storeRecipe()
      $location.search 'building', false

    storeRecipe = () ->
      recipeData = _.pick $scope, recipeFields

      $scope.beer.then (beer) ->
        $cookieStore.put "recipe_builder_#{beer.id}", recipeData

    removeStoredRecipe = () ->
      $scope.beer.then (beer) ->
        $cookieStore.remove "recipe_builder_#{beer.id}"

    $scope.beer.then (beer) ->
      recipeData = $cookieStore.get("recipe_builder_#{beer.id}") || {}
      _.extend $scope, recipeData

    $scope.$on '$destroy', storeRecipe
    $(window).unload storeRecipe
]