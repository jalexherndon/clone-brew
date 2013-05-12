angular.module('clonebrews').controller 'RegistrationController', [
  '$scope'
  '$location'
  'RegistrationService'

  ($scope, $location, RegistrationService) ->
    $scope.signUp = () ->
      $scope.errorMessage = ""
      RegistrationService.signUp(
        email: $scope.email
        password: $scope.password
        first_name: $scope.first_name
        last_name: $scope.last_name
      , $scope.brew_beta_key).then (session) ->
        $location.path '/library'
      , (error) ->
        $scope.brew_beta_key = ''
        $scope.password = ''
        if error.data.message?
          $scope.errorMessage = error.data.message 
        else
          _.forIn error.data, (value, key) ->
            $scope.errorMessage += "#{key} #{value}. "

]