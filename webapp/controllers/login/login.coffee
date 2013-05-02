angular.module('clonebrews').controller 'LoginController', [
  '$scope'
  '$location'
  'SessionService'

  ($scope, $location, SessionService) ->
    $scope.signIn = () ->
      SessionService.signIn($scope.email, $scope.password).then (session) ->
        $location.path '/library'
]