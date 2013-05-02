angular.module('clonebrews').controller 'RegistrationController', [
  '$scope'
  '$location'
  'RegistrationService'

  ($scope, $location, RegistrationService) ->
    $scope.signUp = () ->
      RegistrationService.signUp(
        email: $scope.email
        password: $scope.password
        firstName: $scope.firstName
        lastName: $scope.lastName
      , $scope.betaKey).then (session) ->
        $location.path '/library'
]