angular.module('clonebrews').controller 'LoginController', [
  '$scope'
  '$location'
  'SessionService'

  ($scope, $location, SessionService) ->
    $scope.signIn = () ->
      $scope.errorMessage = ''
      SessionService.signIn($scope.email, $scope.password).then (session) ->
        $location.path '/library'
      , (error) ->
        $scope.errorMessage = error.data.message
        $scope.password = ''
]