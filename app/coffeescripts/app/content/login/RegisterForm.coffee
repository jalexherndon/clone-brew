define "Brew/content/login/RegisterForm", [
    "dojo/_base/declare",
    "dijit/form/Form",
    "dijit/form/ValidationTextBox",
    "dijit/form/Button",
    "dijit/_Container",
    "dojo/dom-construct",
    "dojox/validate/web",
    "dojo/_base/event"
], (declare, Form, TextBox, Button, _Container, DomConstruct, validate, event) ->

    declare "Brew.content.login.RegisterForm", [Form, _Container],
        class: "brew-register-form"

        postCreate: ->
            message = DomConstruct.create "div", {
                class: "brew-register-message"
                innerHTML: "New? Join for free."
            }
            firstName = new TextBox {
                class: "brew-register-name brew-register-first-name"
                name: "firstName"
                placeHolder: "first name"
            }
            lastName = new TextBox {
                class: "brew-register-name"
                name: "lastName"
                placeHolder: "last name"
            }
            email = new TextBox {
                class: "brew-user-name"
                name: "user[email]"
                placeHolder: "email"
                required: true
                validator: validate.isEmailAddress
                invalidMessage: "Must be a valid email."
            }
            password = new TextBox {
                class: "brew-password"
                name: "user[password]"
                type: "password"
                placeHolder: "password"
                required: true
                validator: @_passwordValidator
                constraints:
                    min: 8
            }
            passwordConf = new TextBox {
                class: "brew-password"
                name: "user[password_confirmation]"
                type: "password"
                placeHolder: "confirm password"
                validator: @_passwordConfValidator
                constraints:
                    match: password
            }
            submitButton = new Button {
                class: "brew-button"
                type: "submit"
                label: "Register!"
            }

            @addChild firstName
            @addChild lastName
            @addChild email
            @addChild password
            @addChild passwordConf
            @addChild submitButton
            DomConstruct.place message, @domNode, "first"

        onSubmit: (evt) ->
            event.stop evt
            Brew.auth.LocalProvider.register @get("value")  if @validate()

        _passwordValidator: (value, constraints) ->
            if value.length < constraints.min
                @invalidMessage = "Must be at least 8 characters."
                return false
            true

        _passwordConfValidator: (value, constraints) ->
            if value isnt constraints.match.get("value")
                @invalidMessage = "Must match your password."
                return false
            true
