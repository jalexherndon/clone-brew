angular.module('clonebrews').config([
  '$routeProvider'

  ($routeProvider) ->
    $routeProvider

    .when '/beer/:beerId',
      templateUrl: 'partials/beer/detail'
      controller: 'BeerDetailController'

    .when '/library',
      templateUrl: 'partials/library.html'
      controller: 'LibraryController'

    .when '/login',
      templateUrl: 'partials/login/page.html'
      # controller: 'LoginController'

    .otherwise
      redirectTo: '/login'

]).run ($rootScope, $location) ->
  $rootScope.$on "$routeChangeStart", (event, next, current) ->
    $rootScope.isLoginPage = $location.path().indexOf('login') > -1
