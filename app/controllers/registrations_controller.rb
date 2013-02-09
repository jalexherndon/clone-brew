class RegistrationsController < ApplicationController
  BETA_KEY = "rdwhahb"
  BETA_KEY_PARAM = "brew_beta_key"

  respond_to :json

  def create
    if params[BETA_KEY_PARAM] != BETA_KEY
      warden.custom_failure!
      render :json => {
        :success => false,
        :message => "You must have a valid beta key to register",
        :invalid_field => BETA_KEY_PARAM
      }, :status => 422
      return
    end

    user = User.new(params[:user])
    if user.save
      sign_in("user", user)

      render :json => user.as_json(
        :email => user.email,
        :first_name=>user.first_name,
        :last_name => user.last_name
      ), :status=>201
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

end 