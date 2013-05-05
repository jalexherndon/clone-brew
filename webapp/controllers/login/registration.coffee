angular.module('clonebrews').controller 'RegistrationController', [
  '$scope'
  '$location'
  'RegistrationService'

  ($scope, $location, RegistrationService) ->
    $scope.signUp = () ->
      RegistrationService.signUp(
        email: $scope.email
        password: $scope.password
        first_name: $scope.first_name
        last_name: $scope.last_name
      , $scope.brew_beta_key).then (session) ->
        $location.path '/library'
]