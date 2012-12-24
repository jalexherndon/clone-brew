define 'Brew/content/login/LoginPage', [
    'dojo/_base/declare',
    'Brew/contnent/_Page',
    'dijit/layout/ContentPane',
    'Brew/content/login/LoginForm',
    'Brew/content/login/RegisterForm',
    'dojo/dom-construct'

], (declare, _Page, ContentPane, LoginForm, RegisterForm, DomConstruct) ->

    declare 'Brew.content.login.LoginPage', _Page,
        class: 'brew-login-page'

        postCreate: ->
            @inherited arguments

            welcomeMessageCt = new ContentPane {class: 'brew-welcome-message-ct'}
            welcomeMessage = new ContentPane {
                class: 'brew-welcome-message'
                content: "<h1>Welcome to Clone Brews.</h1>" + "<p class=\"quote\">\"Beer is proof that God loves us and wants us to be happy.\"</p>" + "<p class=\"author\">- Benjamin Franklin</p>"
            }
            photoCredit = new ContentPane {
                class: 'brew-login-photo-credit'
                content: '<a href="http://www.sxc.hu/profile/nutto" target="blank">photo by Dušan Gavenda<br />www.sxc.hu/profile/nutto</a>'
            }
            @addChild welcomeMessageCt
            @addChild welcomeMessage
            @addChild photoCredit
            @addChild new LoginForm()
            @addChild new RegisterForm()
