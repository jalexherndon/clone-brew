(function() {

    define('Brew/content/login/LoginForm', [
        'dojo/_base/declare',
        'dijit/form/Form',
        'dijit/form/ValidationTextBox',
        'dijit/form/Button',
        'dijit/_Container',
        'dojo/request',
        'dojo/dom-construct',
        'dojo/topic',
        'dojo/_base/lang'
    ], function(declare, Form, TextBox, Button, _Container, request, DomConstruct, topic, lang) {

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

            onSubmit: function() {
                if (!this.validate()) {
                    return false;
                }

                request.post('/users/sign_in.json', {
                    handleAs: 'json',
                    data: this.get('value')
                }).then(lang.hitch(this, this._onLoginSuccess), lang.hitch(this, this._onLoginFailure));

                return false;
            },

            _onLoginSuccess: function(response) {
                // TODO: success handler
                console.log('You have logged in successfully.');
                this.reset();
                topic.publish(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, response);
            },

            _onLoginFailure: function(err) {
                // TODO: err handler
                console.log('There was an error in your login:\n\n' + err.message);
                this.reset();
            }
        });
    });
})();