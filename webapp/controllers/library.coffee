angular.module('clonebrews').controller 'LibraryController', [
  '$scope',
  '$location',
  'BeerService',
  'BreweryDBService',

  ($scope, $location, BeerService, BreweryDBService) ->
    @tooltip = $('.icon-remove').tooltip()

    $scope.searchIsActive = false
    $scope.query = null
    $scope.beers = []

    $scope.searchBeers = () =>
      $scope.searchIsActive = true
      BreweryDBService.search(
        q: $scope.query
        type: 'beer'
      ).then (results) ->
        $scope.beers = results

    $scope.goToBeerDetailPage = (beerId) ->
      $location.path "/beer/#{beerId}"

    $scope.resetBeers = () =>
      @tooltip.tooltip('hide')
      $scope.searchIsActive = false
      $scope.query = null
      BeerService.query().then (results) ->
        $scope.beers = results

    $scope.resetBeers()
]
