(function() {

  define('Brew/content/login/LoginForm', ['dojo/_base/declare', 'dijit/form/Form', 'dijit/form/ValidationTextBox', 'dijit/form/Button', 'dijit/_Container', 'dojo/dom-construct', 'dojo/_base/event', 'dojo/_base/lang', 'dojo/query', 'dijit/registry', 'dojo/topic', 'dojo/on', 'dojo/_base/window'], function(declare, Form, TextBox, Button, _Container, DomConstruct, event, lang, query, registry, topic, onn, win) {
    return declare('Brew.content.login.LoginForm', [Form, _Container], {
      "class": 'brew-login-form',
      onShow: function() {
        var body, node, userNameTextBox;
        node = query('.brew-user-name', this.domNode)[0];
        userNameTextBox = registry.byNode(node);
        body = win.body();
        return onn.once(body, 'keydown', function(evt) {
          if (document.activeElement === body) {
            return userNameTextBox.focus();
          }
        });
      },
      postCreate: function() {
        var message, password, submitButton, userName;
        message = DomConstruct.create('div', {
          "class": 'brew-login-message',
          innerHTML: 'Already a member?'
        });
        userName = new TextBox({
          "class": 'brew-user-name',
          name: 'user[email]',
          placeHolder: 'email',
          required: true
        });
        password = new TextBox({
          "class": 'brew-password',
          name: 'user[password]',
          type: 'password',
          placeHolder: 'password',
          required: true
        });
        submitButton = new Button({
          "class": 'brew-button',
          type: 'submit',
          label: 'Sign In'
        });
        this.addChild(userName);
        this.addChild(password);
        this.addChild(submitButton);
        return DomConstruct.place(message, this.domNode, 0);
      },
      onSubmit: function(evt) {
        event.stop(evt);
        if (!this.validate()) {
          return;
        }
        Brew.auth.LocalProvider.login(this.get('value'), {
          failure: lang.hitch(this, this._loginFailCallback)
        });
        return this.inherited(arguments);
      },
      _loginFailCallback: function(err) {
        var message, node, passwordTextBox;
        message = err.response.data.message;
        node = query('.brew-password', this.domNode)[0];
        passwordTextBox = registry.byNode(node);
        passwordTextBox.focus();
        passwordTextBox.set('value', '');
        return passwordTextBox.displayMessage(message);
      }
    });
  });

}).call(this);
