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
    $scope.currentPage = 1

    $scope.searchBeers = (page=1) ->
      $scope.searchIsActive = true
      BreweryDBService.search(
        q: $scope.query
        type: 'beer'
        p: page
      ).then (results) ->
        $scope.beers = results

    $scope.clearSearch =() ->
      $scope.query = null
      $scope.searchIsActive = false
      $scope.goToPage 1

    $scope.goToBeerDetailPage = (beerId) ->
      $location.path "/beer/#{beerId}"

    $scope.goToPage = (page=1) =>
      if page < 1 or ($scope.beers.length < 50 && page > $scope.currentPage)
        return

      if $scope.searchIsActive 
        $scope.searchBeers page
        return

      @tooltip.tooltip('hide')
      $scope.currentPage = page

      BeerService.query(p: page).then (results) ->
        $scope.beers = results

    $scope.goToPage $scope.currentPage
]
