angular.module('clonebrews').service 'SessionService', [
  '$log'
  '$q'
  '$resource'
  '$rootScope'
  '$cookieStore'

  ($log, $q, $resource, $rootScope, $cookieStore) ->
    SESSION_COOKIE_NAME = 'session'
    UserSession = $resource '/users/:action.json', {},
      signIn:
        method: 'Post'
        params:
          action: 'sign_in'

      signOut:
        method: 'DELETE'
        params:
          action: 'sign_out'

    @signIn = (email, password) ->
      defer = $q.defer()

      if $cookieStore.get(SESSION_COOKIE_NAME)
        defer.reject(message: 'already logged in')

      new UserSession(
        user:
          email: email
          password: password
      ).$signIn (session) ->
        $rootScope.isLoggedIn = true
        $cookieStore.put(SESSION_COOKIE_NAME, session)
        defer.resolve session
      , (error) ->
        $rootScope.isLoggedIn = false
        $cookieStore.remove(SESSION_COOKIE_NAME)
        $log.error 'SessionService.signIn error', error
        defer.reject error

      defer.promise

    @signOut = () ->
      defer = $q.defer()

      session = $cookieStore.get(SESSION_COOKIE_NAME)
      new UserSession(
        user:
          email: session.email
      ).$signOut (session) ->
        $rootScope.isLoggedIn = false
        $cookieStore.remove(SESSION_COOKIE_NAME)
        defer.resolve session
      , (error) ->
        $log.error 'SessionService.signOut error', error
        defer.reject error

      defer.promise


    $rootScope.isLoggedIn = $cookieStore.get(SESSION_COOKIE_NAME)?
]