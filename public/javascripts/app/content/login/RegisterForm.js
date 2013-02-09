(function() {

  define("Brew/content/login/RegisterForm", ["dojo/_base/declare", "dijit/form/Form", "dijit/form/ValidationTextBox", "dijit/form/Button", "dijit/_Container", "dojo/dom-construct", "dojox/validate/web", "dojo/_base/event"], function(declare, Form, ValidationTextBox, Button, _Container, DomConstruct, validate, event) {
    return declare("Brew.content.login.RegisterForm", [Form, _Container], {
      "class": "brew-register-form",
      postCreate: function() {
        var betaKey, email, firstName, lastName, message, password, submitButton;
        message = DomConstruct.create("div", {
          "class": "brew-register-message",
          innerHTML: "New? Join for free."
        });
        firstName = new ValidationTextBox({
          "class": "brew-register-name brew-register-first-name",
          name: "user[first_name]",
          placeHolder: "first name"
        });
        lastName = new ValidationTextBox({
          "class": "brew-register-name",
          name: "user[last_name]",
          placeHolder: "last name"
        });
        email = new ValidationTextBox({
          "class": "brew-user-name",
          name: "user[email]",
          placeHolder: "email",
          required: true,
          validator: validate.isEmailAddress,
          invalidMessage: "Must be a valid email."
        });
        password = new ValidationTextBox({
          "class": "brew-password",
          name: "user[password]",
          type: "password",
          placeHolder: "password",
          required: true,
          validator: this._passwordValidator,
          constraints: {
            min: 8
          }
        });
        betaKey = new ValidationTextBox({
          "class": "brew-password",
          name: "brew_beta_key",
          type: "password",
          placeHolder: "beta key",
          required: true
        });
        submitButton = new Button({
          "class": "brew-button",
          type: "submit",
          label: "Register!"
        });
        this.addChild(firstName);
        this.addChild(lastName);
        this.addChild(email);
        this.addChild(password);
        this.addChild(betaKey);
        this.addChild(submitButton);
        return DomConstruct.place(message, this.domNode, "first");
      },
      onSubmit: function(evt) {
        var _this = this;
        event.stop(evt);
        if (this.validate()) {
          return Brew.auth.LocalProvider.register(this.get("value"), {
            failure: function(err) {
              var betaKeyTextBox, _ref, _ref1;
              if (((_ref = err.response) != null ? (_ref1 = _ref.data) != null ? _ref1.invalid_field : void 0 : void 0) === "brew_beta_key") {
                betaKeyTextBox = _this.getChildren()[5];
                betaKeyTextBox.set("value", "");
                betaKeyTextBox.focus();
                betaKeyTextBox.set("state", "Error");
                return betaKeyTextBox.set("message", err.response.data.message);
              }
            }
          });
        }
      },
      _passwordValidator: function(value, constraints) {
        if (value.length < constraints.min) {
          this.invalidMessage = "Must be at least 8 characters.";
          return false;
        }
        return true;
      }
    });
  });

}).call(this);
