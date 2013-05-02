angular.module('clonebrews').service 'SessionService', [
  '$log'
  '$q'
  '$resource'
  '$rootScope'
  '$cookieStore'

  ($log, $q, $resource, $rootScope, $cookieStore) ->
    UserSession = $resource '/users/:action.json',
      'user[email]': '@user.email'
      'user[password]': '@user.password'
    ,
      signIn:
        method: 'POST'
        params:
          action: 'sign_in'

      signOut:
        method: 'DELETE'
        params:
          action: 'sign_out'

    @signIn = (email, password) ->
      defer = $q.defer()

      if $cookieStore.get('session')
        defer.reject(message: 'already logged in')

      new UserSession(
        user:
          email: email
          password: password
      ).$signIn (session) ->
        $rootScope.isLoggedIn = true
        $cookieStore.put('session', session)
        defer.resolve session
      , (error) ->
        $rootScope.isLoggedIn = false
        $cookieStore.remove('session')
        $log.error 'SessionService.signIn error', error
        defer.reject error

      defer.promise

    @signOut = () ->
      defer = $q.defer()

      session = $cookieStore.get('session')
      new UserSession(
        user:
          email: session.email
      ).$signOut (session) ->
        $rootScope.isLoggedIn = false
        $cookieStore.remove('session')
        defer.resolve session
      , (error) ->
        $log.error 'SessionService.signOut error', error
        defer.reject error

      defer.promise


    $rootScope.isLoggedIn = $cookieStore.get('session')?
]