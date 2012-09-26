(function() {

    define('Brew/content/login/RegisterForm', [
        'dojo/_base/declare',
        'dijit/form/Form',
        'dijit/form/ValidationTextBox',
        'dijit/form/Button',
        'dijit/_Container',
        'dojo/dom-construct',
        'dojox/validate/web',
        'dojo/_base/event'
        
    ], function(declare, Form, TextBox, Button, _Container, DomConstruct, validate, event){

        return declare('Brew.content.login.RegisterForm', [Form, _Container], {
            'class': 'brew-register-form',

            postCreate: function() {
                var message = DomConstruct.create("div", {
                        'class': 'brew-register-message',
                        innerHTML: 'New? Join for free.'
                    }),
                    firstName = new TextBox({
                        'class': 'brew-register-name brew-register-first-name',
                        name: 'firstName',
                        placeHolder: 'first name'
                    }),
                    lastName = new TextBox({
                        'class': 'brew-register-name',
                        name: 'lastName',
                        placeHolder: 'last name'
                    }),
                    email = new TextBox({
                        'class': 'brew-user-name',
                        name: 'user[email]',
                        placeHolder: 'email',
                        required: true,
                        validator: validate.isEmailAddress,
                        invalidMessage:'Must be a valid email.'
                    }),
                    password = new TextBox({
                        'class': 'brew-password',
                        name: 'user[password]',
                        type: 'password',
                        placeHolder: 'password',
                        required: true,
                        validator: this._passwordValidator,
                        constraints: {min:8}
                    }),
                    passwordConf = new TextBox({
                        'class': 'brew-password',
                        name: 'user[password_confirmation]',
                        type: 'password',
                        placeHolder: 'confirm password',
                        validator: this._passwordConfValidator,
                        constraints: {
                            match: password
                        }
                    }),
                    submitButton = new Button({
                        'class': 'brew-button',
                        type: 'submit',
                        label: 'Register!'
                    });

                this.addChild(firstName);
                this.addChild(lastName);
                this.addChild(email);
                this.addChild(password);
                this.addChild(passwordConf);
                this.addChild(submitButton);
                DomConstruct.place(message, this.domNode, 'first');
            },

            onSubmit: function(evt) {
                event.stop(evt);
                if (this.validate()) {
                    Brew.auth.LocalProvider.regiser(this.get('value'));
                }
            },

            _passwordValidator: function(value, constraints) {
                if (value.length < constraints.min) {
                    this.invalidMessage = 'Must be at least 8 characters.';
                    return false;
                }

                return true;
            },

            _passwordConfValidator: function(value, constraints) {
                if (value !== constraints.match.get('value')) {
                    this.invalidMessage = 'Must match your password.';
                    return false;
                }

                return true;
            }
        });
    });
})();