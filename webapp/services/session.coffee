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
          user: '@user'

    @signIn = (email, password) ->
      defer = $q.defer()

      session = $cookieStore.get(SESSION_COOKIE_NAME)
      if session?
        defer.resolve(session)
      else
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
      if session?
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
      else
          defer.resolve message: 'already logged out'

      defer.promise


    $rootScope.isLoggedIn = $cookieStore.get(SESSION_COOKIE_NAME)?
]