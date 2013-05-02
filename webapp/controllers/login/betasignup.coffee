angular.module('clonebrews').controller 'BetaSignUpController', [
  '$scope'
  'BetaUserService'

  ($scope, BetaUserService) ->
    $scope.betaSignUp = () ->
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

]