(function() {

  define('Brew/auth/LocalProvider', ['dojo/_base/declare', 'dojo/_base/lang', 'dojo/request/notify', 'dojo/_base/query', 'dojo/request', 'dojo/cookie', 'dojo/topic'], function(declare, lang, notify, query, request, cookie, topic) {
    var LocalProvider;
    LocalProvider = declare('Brew.auth.LocalProvider', null, {
      CSRFToken: null,
      currentUser: null,
      cookieName: 'user',
      _isAuthenticated: false,
      constructor: function(config) {
        var _this = this;
        this.CSRFToken = query("meta[name='csrf-token']")[0].getAttribute('content');
        return notify('send', function(response, cancel) {
          var _ref;
          return (_ref = response.xhr) != null ? _ref.setRequestHeader('X-CSRF-Token', _this.CSRFToken) : void 0;
        });
      },
      startup: function() {
        var user;
        user = cookie(this.cookieName);
        if (user) {
          this._isAuthenticated = true;
          return topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user);
        } else {
          this._isAuthenticated = false;
          return topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED, user);
        }
      },
      login: function(data, failureCallback) {
        return request.post('/users/sign_in.json', {
          handleAs: 'json',
          data: data
        }).then(lang.hitch(this, this._onAuthSuccess), failureCallback);
      },
      register: function(data) {
        return request.post('/users.json', {
          handleAs: 'json',
          data: data
        }).then(lang.hitch(this, this._onAuthSuccess), lang.hitch(this, this._onAuthNeeded));
      },
      logout: function() {
        return request.del('/users/sign_out.json').then(lang.hitch(this, this._onAuthNeeded));
      },
      isAuthenticated: function() {
        return this._isAuthenticated;
      },
      _onAuthSuccess: function(user) {
        this._isAuthenticated = true;
        cookie(this.cookieName, user);
        return topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user);
      },
      _onAuthNeeded: function(err) {
        this._isAuthenticated = false;
        cookie(this.cookieName, null, {
          expires: -1
        });
        return topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED);
      }
    });
    lang.getObject('auth.LocalProvider', true, Brew);
    Brew.auth.LocalProvider = new LocalProvider();
    return Brew.auth.LocalProvider;
  });

}).call(this);
