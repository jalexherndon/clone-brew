define "Brew/content/login/LoginForm", [
    "dojo/_base/declare",
    "dijit/form/Form",
    "dijit/form/ValidationTextBox",
    "dijit/form/Button",
    "dijit/_Container",
    "dojo/dom-construct",
    "dojo/_base/event",
    "dojo/_base/lang",
    "dojo/query",
    "dijit/registry"

], (declare, Form, TextBox, Button, _Container, DomConstruct, event, lang, query, registry) ->

    declare "Brew.content.login.LoginForm", [Form, _Container],
        class: "brew-login-form"

        postCreate: ->
            message = DomConstruct.create "div", {
                class: "brew-login-message"
                innerHTML: "Already a member?"
            }
            userName = new TextBox {
                class: "brew-user-name"
                name: "user[email]"
                placeHolder: "email"
                required: true
            }
            password = new TextBox {
                class: "brew-password"
                name: "user[password]"
                type: "password"
                placeHolder: "password"
                required: true
            }
            submitButton = new Button {
                class: "brew-button"
                type: "submit"
                label: "Sign In"
            }

            @addChild userName
            @addChild password
            @addChild submitButton
            DomConstruct.place message, @domNode, 0

        onSubmit: (evt) ->
            event.stop evt
            Brew.auth.LocalProvider.login @get("value"), lang.hitch(this, @_loginFailCallback)  if @validate()
            @inherited arguments

        _loginFailCallback: (err) ->
            message = err.response.data.error
            node = query(".brew-password", @domNode)[0]
            passwordTextBox = registry.byNode(node)
            
            passwordTextBox.focus()
            passwordTextBox.set "value", ""
            passwordTextBox.displayMessage message
