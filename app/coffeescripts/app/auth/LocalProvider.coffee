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
        _isAuthenticated: false

        constructor: (config) ->
            @CSRFToken = query("meta[name='csrf-token']")[0].getAttribute('content')
            notify 'send', (response, cancel) =>
                response.xhr?.setRequestHeader 'X-CSRF-Token', @CSRFToken

        startup: ->
            user = cookie(@cookieName)
            if user
                @_isAuthenticated = true
                topic.publish Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user
            else
                @_isAuthenticated = false
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

        isAuthenticated: ->
            @_isAuthenticated

        _onAuthSuccess: (user) ->
            @_isAuthenticated = true
            cookie @cookieName, user
            topic.publish Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user

        _onAuthNeeded: (err) ->
            @_isAuthenticated = false
            cookie @cookieName, null,
                expires: -1

            topic.publish Brew.util.Messages.AUTHORIZATION_NEEDED


    lang.getObject 'auth.LocalProvider', true, Brew
    Brew.auth.LocalProvider = new LocalProvider()
    Brew.auth.LocalProvider
