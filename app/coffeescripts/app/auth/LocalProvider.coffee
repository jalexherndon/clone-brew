define 'Brew/auth/LocalProvider', [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dojo/request/notify',
  'dojo/_base/query',
  'dojo/request',
  'dojo/cookie',
  'dojo/topic'

], (declare, lang, notify, query, request, cookie, topic) ->

  LocalProvider = declare 'Brew.auth.LocalProvider', null,
    CSRFToken: null
    currentUser: null
    cookieName: 'user'

    constructor: (config) ->
      @CSRFToken = query("meta[name='csrf-token']")[0].getAttribute('content')
      notify 'send', (response, cancel) =>
        response.xhr?.setRequestHeader 'X-CSRF-Token', @CSRFToken

    startup: ->
      user = @getCurrentUser()
      if user?
        topic.publish Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user
      else
        topic.publish Brew.util.Messages.AUTHORIZATION_NEEDED, user

    login: (data, failureCallback) ->
      request.post('/users/sign_in.json',
        handleAs: 'json'
        data: data
      ).then lang.hitch(this, @_onAuthSuccess), failureCallback

    register: (data) ->
      request.post('/users.json',
        handleAs: 'json'
        data: data
      ).then lang.hitch(this, @_onAuthSuccess), lang.hitch(this, @_onAuthNeeded)

    logout: ->
      request.del('/users/sign_out.json').then lang.hitch(this, @_onAuthNeeded)

    isAuthenticated: (fireAuthEvent) ->
      authenticated = cookie(@cookieName)?
      if fireAuthEvent and not authenticated
        topic.publish Brew.util.Messages.AUTHORIZATION_NEEDED

      authenticated

    getCurrentUser: () ->
      cookie(@cookieName)

    _onAuthSuccess: (user) ->
      cookie @cookieName, user
      topic.publish Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user

    _onAuthNeeded: (err) ->
      cookie @cookieName, null,
        expires: -1

      topic.publish Brew.util.Messages.AUTHORIZATION_NEEDED


  lang.getObject 'auth.LocalProvider', true, Brew
  Brew.auth.LocalProvider = new LocalProvider()
  Brew.auth.LocalProvider
