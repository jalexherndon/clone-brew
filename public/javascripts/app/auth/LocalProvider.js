(function() {

  define('Brew/auth/LocalProvider', ['dojo/_base/declare', 'dojo/_base/lang', 'dojo/request/notify', 'dojo/_base/query', 'dojo/request', 'dojo/cookie', 'dojo/json', 'dojo/topic'], function(declare, lang, notify, query, request, cookie, json, topic) {
    var LocalProvider;
    LocalProvider = declare('Brew.auth.LocalProvider', null, {
      CSRFToken: null,
      cookieName: 'user',
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
        user = this.getCurrentUser();
        if (user != null) {
          return topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user);
        } else {
          return topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED, user);
        }
      },
      register: function(data, opts) {
        return request.post('/users.json', {
          handleAs: 'json',
          data: data
        }).then(lang.hitch(this, this._onAuthSuccess, opts), lang.hitch(this, this._onAuthNeeded, opts));
      },
      login: function(data, opts) {
        return request.post('/users/sign_in.json', {
          handleAs: 'json',
          data: data
        }).then(lang.hitch(this, this._onAuthSuccess, opts), opts != null ? opts.failure : void 0);
      },
      logout: function() {
        return request.del('/users/sign_out.json', {
          handleAs: 'json',
          data: {
            user: json.stringify(this.getCurrentUser)
          }
        }).then(lang.hitch(this, this._onAuthNeeded));
      },
      isAuthenticated: function(fireAuthEvent) {
        var authenticated;
        authenticated = this.getCurrentUser() != null;
        if (fireAuthEvent && !authenticated) {
          topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED);
        }
        return authenticated;
      },
      getCurrentUser: function() {
        var user_json;
        user_json = cookie(this.cookieName) || null;
        return json.parse(user_json);
      },
      _onAuthSuccess: function(opts, user) {
        cookie(this.cookieName, json.stringify(user));
        topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, user);
        return opts != null ? typeof opts.success === "function" ? opts.success(user) : void 0 : void 0;
      },
      _onAuthNeeded: function(opts, err) {
        cookie(this.cookieName, null, {
          expires: -1
        });
        topic.publish(Brew.util.Messages.AUTHORIZATION_NEEDED);
        return opts != null ? typeof opts.failure === "function" ? opts.failure(err) : void 0 : void 0;
      }
    });
    lang.getObject('auth.LocalProvider', true, Brew);
    Brew.auth.LocalProvider = new LocalProvider();
    return Brew.auth.LocalProvider;
  });

}).call(this);
