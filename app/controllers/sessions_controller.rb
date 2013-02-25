class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create ]
  before_filter :ensure_params_exist
 
  respond_to :json
  
  def create
    build_resource
    user = User.find_for_database_authentication(:email=>params[:user][:email])
    return invalid_login_attempt if user.nil?
 
    if user.valid_password?(params[:user][:password])
      sign_in("user", user)
      render :json =>  user.as_json(
        :successfull  => true,
        :email        => user.email,
        :first_name   => user.first_name,
        :last_name    => user.last_name
      )
      return
    end
    invalid_login_attempt
  end
  
  def destroy
    sign_out(resource_name)
    render :json => {
      :success => true,
      :message => "Logout successfull"
    }, status => 200
  end
 
  protected
  def ensure_params_exist
    return unless params[:user].blank?
    render :json=> {:success=>false, :message=>"missing user parameter"}, :status=>422
  end
 
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end