define "Brew/content/login/RegisterForm", [
    "dojo/_base/declare",
    "dijit/form/Form",
    "dijit/form/ValidationTextBox",
    "dijit/form/Button",
    "dijit/_Container",
    "dojo/dom-construct",
    "dojox/validate/web",
    "dojo/_base/event"
], (declare, Form, ValidationTextBox, Button, _Container, DomConstruct, validate, event) ->

    declare "Brew.content.login.RegisterForm", [Form, _Container],
        class: "brew-register-form"

        postCreate: ->
            message = DomConstruct.create "div", {
                class: "brew-register-message"
                innerHTML: "New? Join for free."
            }
            firstName = new ValidationTextBox {
                class: "brew-register-name brew-register-first-name"
                name: "user[first_name]"
                placeHolder: "first name"
            }
            lastName = new ValidationTextBox {
                class: "brew-register-name"
                name: "user[last_name]"
                placeHolder: "last name"
            }
            email = new ValidationTextBox {
                class: "brew-user-name"
                name: "user[email]"
                placeHolder: "email"
                required: true
                validator: validate.isEmailAddress
                invalidMessage: "Must be a valid email."
            }
            password = new ValidationTextBox {
                class: "brew-password"
                name: "user[password]"
                type: "password"
                placeHolder: "password"
                required: true
                validator: @_passwordValidator
                constraints:
                    min: 8
            }
            passwordConf = new ValidationTextBox {
                class: "brew-password"
                name: "user[password_confirmation]"
                type: "password"
                placeHolder: "confirm password"
                validator: @_passwordConfValidator
                constraints:
                    match: password
            }
            betaKey = new ValidationTextBox {
                class: "brew-password"
                name: "brew_beta_key"
                type: "password"
                placeHolder: "beta key"
                required: true
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
            @addChild betaKey
            @addChild submitButton
            DomConstruct.place message, @domNode, "first"

        onSubmit: (evt) ->
            event.stop evt
            if @validate()
              Brew.auth.LocalProvider.register @get("value"), {
                failure: (err) =>
                  if err.response?.data?.invalid_field is "brew_beta_key"
                    betaKeyTextBox = @getChildren()[5]
                    betaKeyTextBox.set("value", "")
                    betaKeyTextBox.focus()
                    betaKeyTextBox.set("state", "Error")
                    betaKeyTextBox.set("message", err.response.data.message)
              }

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
