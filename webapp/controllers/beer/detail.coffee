angular.module('clonebrews').controller 'BeerDetailController', [
  '$scope'
  '$routeParams'
  'BeerService'
  'RecipeService'

  ($scope, $routeParams, BeerService, RecipeService) ->
    beerId = $routeParams.beerId
    $scope.beer = BeerService.get beerId

    $scope.recipes = []
    RecipeService.query(beer_id: beerId).then (results) ->
      $scope.recipes = results
    , (response) ->
      if response.status is 401
        $scope.recipes = null
]