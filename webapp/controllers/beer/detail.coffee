angular.module('clonebrews').controller 'BeerDetailController', [
  '$scope'
  '$routeParams'
  '$location'
  'BeerService'
  'RecipeService'

  ($scope, $routeParams, $location, BeerService, RecipeService) ->
    beerId = $routeParams.beerId
    $scope.beer = BeerService.get beerId

    $scope.building = $location.search().building is true
    $scope.$watch 'building', (newValue, oldValue) ->
      unless newValue is oldValue
        $location.search 'building', newValue

    RecipeService.query(beer_id: beerId).then (results) ->
      $scope.recipes = results
]