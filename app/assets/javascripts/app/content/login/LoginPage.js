(function() {

    define('Brew/content/login/LoginPage', [
        'dojo/_base/declare',
        'Brew/content/_Page',
        'dijit/layout/ContentPane',
        'Brew/content/login/LoginForm',
        'Brew/content/login/RegisterForm',
        'dojo/dom-construct'
    ], function(declare, Page, ContentPane, LoginForm, RegisterForm, DomConstruct){

        return declare('Brew.content.login.LoginPage', Page, {
            'class': 'brew-login-page',

            postCreate: function() {
                this.inherited(arguments);

                var welcomeMessageCt = DomConstruct.create('div', {
                        'class': 'brew-welcome-message-ct'
                    }),
                    welcomeMessage = DomConstruct.create('div', {
                        'class': 'brew-welcome-message',
                        innerHTML: '<h1>Welcome to Clone Brews.</h1>' +
                                    '<p class="quote">"Beer is proof that God loves us and wants us to be happy."</p>' +
                                    '<p class="author">- Benjamin Franklin</p>'
                    }),
                    pane = new ContentPane({'class': 'brew-login-ct'});

                pane.addChild(new LoginForm());
                pane.addChild(new RegisterForm());
                this.addChild(pane);

                DomConstruct.place(welcomeMessage, this.domNode, 0);
                DomConstruct.place(welcomeMessageCt, this.domNode, 0);
            }
        });
    });

})();