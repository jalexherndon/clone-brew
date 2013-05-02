angular.module('clonebrews').controller 'RegistrationController', [
  '$scope'
  'RegistrationService'

  ($scope, RegistrationService) ->
    $scope.signUp = () ->
      RegistrationService.signUp 
        email: $scope.email
        password: $scope.password
        firstName: $scope.firstName
        lastName: $scope.lastName
      , $scope.betaKey

]