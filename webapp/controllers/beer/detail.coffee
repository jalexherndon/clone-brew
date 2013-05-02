angular.module('clonebrews').controller 'BeerDetailController', [
  '$scope'
  '$routeParams'
  'BeerService'
  'RecipeService'

  ($scope, $routeParams, BeerService, RecipeService) ->
    beerId = $routeParams.beerId
    $scope.beer = BeerService.get beerId

    RecipeService.query(beer_id: beerId).then (results) ->
      $scope.recipes = results
]