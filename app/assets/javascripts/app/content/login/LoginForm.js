define('Brew/content/login/LoginForm', [
    'dojo/_base/declare',
    'dijit/form/Form',
    'dijit/form/TextBox',
    'dijit/form/Button',
    'dijit/_Container',
    'dojo/dom-construct'
], function(declare, Form, TextBox, Button, _Container, DomConstruct){

    return declare('Brew.content.login.LoginForm', [Form, _Container], {
        'class': 'brew-login-form',

        onSubmit: function() {
            console.log('login form submit');
        },

        postCreate: function() {
            var message = DomConstruct.create("div", {
                    'class': 'brew-login-message',
                    innerHTML: 'Already a member?'
                }),
                userName = new TextBox({
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
                submitButton = new Button({
                    'class': 'brew-button',
                    type: 'submit',
                    label: 'Sign In'
                });

            this.addChild(userName);
            this.addChild(password);
            this.addChild(submitButton);
            DomConstruct.place(message, this.domNode, 0);
        }
    });
});