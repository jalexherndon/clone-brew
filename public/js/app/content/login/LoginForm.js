(function() {

    define('Brew/content/login/LoginForm', [
        'dojo/_base/declare',
        'dijit/form/Form',
        'dijit/form/ValidationTextBox',
        'dijit/form/Button',
        'dijit/_Container',
        'dojo/dom-construct',
        'dojo/_base/event',
        'dojo/_base/lang',
        'dojo/query',
        'dijit/registry'
    ], function(declare, Form, TextBox, Button, _Container, DomConstruct, event, lang, query, registry) {

        return declare('Brew.content.login.LoginForm', [Form, _Container], {
            'class': 'brew-login-form',

            postCreate: function() {
                var message = DomConstruct.create("div", {
                        'class': 'brew-login-message',
                        innerHTML: 'Already a member?'
                    }),
                    userName = new TextBox({
                        'class': 'brew-user-name',
                        name: 'user[email]',
                        placeHolder: 'email',
                        required: true
                    }),
                    password = new TextBox({
                        'class': 'brew-password',
                        name: 'user[password]',
                        type: 'password',
                        placeHolder: 'password',
                        required: true
                    }),
                    submitButton = new Button({
                        'class': 'brew-button',
                        type: 'submit',
                        label: 'Sign In'
                    });

                this.addChild(userName);
                this.addChild(password);
                this.addChild(submitButton);
                DomConstruct.place(message, this.domNode, 0);
            },

            onSubmit: function(evt) {
                event.stop(evt);
                if (this.validate()) {
                    Brew.auth.LocalProvider.login(this.get('value'), lang.hitch(this, this._loginFailCallback));
                }
                this.inherited(arguments);
            },

            _loginFailCallback: function(err) {
                var message = err.response.data.error,
                    node = query('.brew-password', this.domNode)[0],
                    passwordTextBox = registry.byNode(node);

                passwordTextBox.focus();
                passwordTextBox.set('value', '');
                passwordTextBox.displayMessage(message);
            }

        });
    });
})();