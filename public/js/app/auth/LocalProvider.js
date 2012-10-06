(function() {
    define('Brew/auth/LocalProvider', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/request/notify',
        'dojo/_base/query',
        'dojo/request',
        'dojo/cookie',
        'dojo/topic'
    ], function(declare, lang, notify, query, request, cookie, topic) {

        var LocalProvider = declare('Brew.auth.LocalProvider', null, {

            CSRFToken: null,
            currentUser: null,
            cookieName: 'user',
            _isAuthenticated: false,

            constructor: function(config) {
                this.CSRFToken = query('meta[name="csrf-token"]')[0].getAttribute('content');

                notify("send", function(response, cancel){
                    response.xhr.setRequestHeader('X-CSRF-Token', this.CSRFToken);
                });

                return this.inherited(arguments);
            },

            startup: function() {
                var user = cookie(this.cookieName);
                if (user) {
                    this._isAuthenticated = true;
                    topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user);
                } else {
                    this._isAuthenticated = false;
                    topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED, user);
                }
            },

            login: function(data, failureCallback) {
                request.post('/users/sign_in.json', {
                    handleAs: 'json',
                    data: data
                }).then(lang.hitch(this, this._onAuthSuccess), failureCallback);
            },

            register: function(data) {
                request.post('/users.json', {
                    handleAs: 'json',
                    data: data
                }).then(lang.hitch(this, this._onAuthSuccess), lang.hitch(this, this._onAuthNeeded));
            },

            logout: function() {
                request.del('/users/sign_out.json').then(lang.hitch(this, this._onAuthNeeded));
            },

            isAuthenticated: function() {
                return this._isAuthenticated;
            },

            _onAuthSuccess: function(user) {
                this._isAuthenticated = true;
                cookie(this.cookieName, user);
                topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user);
            },

            _onAuthNeeded: function(err) {
                this._isAuthenticated = false;
                cookie(this.cookieName, null, {expires: -1});
                topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED);
            }
        });

        lang.getObject("auth.LocalProvider", true, Brew);
        Brew.auth.LocalProvider = new LocalProvider();
        return Brew.auth.LocalProvider;
    });
})();