angular.module('clonebrews').config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when '/library',
    templateUrl: 'partials/library.html'
    controller: 'LibraryController'
  # .when '/github/:searchTerm',
  #   controller: 'gitHubController'
  #   reloadOnSearch: true
  #   resolve:
  #     changeTab: ['$rootScope', ($rootScope) ->
  #       $rootScope.$broadcast 'changeTab#gitHub'
  #     ]
  # .when '/people/:id',
  #   controller: 'personDetailsController'
  #   reloadOnSearch: true
  #   resolve:
  #     changeTab: ['$rootScope', ($rootScope) ->
  #       $rootScope.$broadcast 'changeTab#people'
  #     ]
  # .otherwise
  #   redirectTo: '/github'
]