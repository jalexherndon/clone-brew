(function() {

  define('Brew/content/login/LoginPage', ['dojo/_base/declare', 'Brew/ui/_Page', 'dijit/layout/ContentPane', 'Brew/content/login/LoginForm', 'Brew/content/login/RegisterForm', 'dojo/dom-construct'], function(declare, _Page, ContentPane, LoginForm, RegisterForm, DomConstruct) {
    return declare('Brew.content.login.LoginPage', _Page, {
      "class": 'brew-login-page',
      postCreate: function() {
        var welcomeMessage, welcomeMessageCt;
        this.inherited(arguments);
        welcomeMessageCt = new ContentPane({
          "class": 'brew-welcome-message-ct'
        });
        welcomeMessage = new ContentPane({
          "class": 'brew-welcome-message',
          content: "<h1>Welcome to Clone Brews.</h1>" + "<p class=\"quote\">\"Beer is proof that God loves us and wants us to be happy.\"</p>" + "<p class=\"author\">- Benjamin Franklin</p>"
        });
        this.addChild(welcomeMessageCt);
        this.addChild(welcomeMessage);
        this.addChild(new LoginForm());
        return this.addChild(new RegisterForm());
      }
    });
  });

}).call(this);
