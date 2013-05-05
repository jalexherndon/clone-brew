angular.module('clonebrews').service 'RegistrationService', [
  '$log',
  '$q',
  '$resource'
  '$rootScope'
  '$cookieStore'

  ($log, $q, $resource, $rootScope, $cookieStore) ->
    UserRegistration = $resource '/users.json', {},
      signUp:
        method: 'POST'

    @signUp = (userData, betaKey) ->
      defer = $q.defer()

      if $cookieStore.get('session')?
        defer.reject({message: 'already logged in'})

      new UserRegistration(
        user: userData
        brew_beta_key: betaKey
      ).$signUp (session) ->
        $rootScope.isLoggedIn = true
        $cookieStore.put('session', session)
        defer.resolve session
      , (error) ->
        $rootScope.isLoggedIn = false
        $cookieStore.remove('session')
        $log.error 'SessionService.signUp error', error
        defer.reject error

      defer.promise


    $rootScope.isLoggedIn = $cookieStore.get('session')?
]