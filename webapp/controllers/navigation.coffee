angular.module('clonebrews').controller 'NavigationController', [
  '$scope'
  '$location'
  'SessionService'

  ($scope, $location, SessionService) ->
    $scope.navigations = [{
      name: 'Library'
      href: 'library'
    }]

    $scope.userActions = [{
      name: 'Log out'
      method: () ->
        SessionService.signOut().then () ->
          $location.path '/'
        
    }]
 
    # $scope.search = (searchTerm) ->
    #   $location.path "/github/#{searchTerm}"

    # $scope.onRouteChange = (routeParams) ->
    #   $scope.searchTerm = routeParams.searchTerm

    #   gitHubService.get($scope.searchTerm).then (results) ->
    #     $scope.repos = results
]
