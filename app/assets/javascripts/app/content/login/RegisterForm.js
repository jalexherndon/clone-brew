define('Brew/content/login/RegisterForm', [
    'dojo/_base/declare',
    'dijit/form/Form',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dijit/_Container',
    'dojo/dom-construct'
], function(declare, Form, TextBox, Button, _Container, DomConstruct){

    return declare('Brew.content.login.RegisterForm', [Form, _Container], {
        'class': 'brew-register-form',

        onSubmit: function() {
            console.log('login form submit');
        },

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
                    name: 'email',
                    placeHolder: 'email'
                }),
                password = new TextBox({
                    'class': 'brew-password',
                    name: 'password',
                    type: 'password',
                    placeHolder: 'password'
                }),
                passwordConf = new TextBox({
                    'class': 'brew-password',
                    name: 'password_confirmation',
                    type: 'password',
                    placeHolder: 'confirm password'
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
        }
    });
});