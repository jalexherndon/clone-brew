angular.module('clonebrews').controller 'NavigationController', [
  '$scope',
  '$location',

  ($scope, $location) ->
    $scope.navigations = [{
      name: 'Library'
      href: 'library'
    }]

    $scope.userActions = [{
      name: 'Log out'
      href: ''
    }]
 
    # $scope.search = (searchTerm) ->
    #   $location.path "/github/#{searchTerm}"

    # $scope.onRouteChange = (routeParams) ->
    #   $scope.searchTerm = routeParams.searchTerm

    #   gitHubService.get($scope.searchTerm).then (results) ->
    #     $scope.repos = results
]
