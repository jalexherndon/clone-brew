angular.module('clonebrews').controller 'BetaSignUpController', [
  '$scope'
  'BetaUserService'

  ($scope, BetaUserService) ->
    $scope.betaSignUp = () ->
      $scope.successMessage = ""
      $scope.errorMessage = ""
      BetaUserService.save(
        first_name: $scope.first_name
        last_name: $scope.last_name
        email: $scope.email
        beta_interest: $scope.beta_interest
      ).then (result) ->
        $scope.first_name = ''
        $scope.last_name = ''
        $scope.email = ''
        $scope.beta_interest = false
        $scope.successMessage = "Thank you for your support! We will keep you posted on our progress."
      , (error) ->
        _.forIn error.data, (value, key) ->
          $scope.errorMessage += "#{key} #{value}. "

]