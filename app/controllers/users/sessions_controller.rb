class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user
      unless @user.is_active?
        redirect_to new_user_session_path, alert: "Your account is inactive!" 
        return
      end
    end

    self.resource = warden.authenticate!(auth_options)

    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    !session[:return_to].blank? ? redirect_to(session[:return_to]) : respond_with(resource, :location => after_sign_in_path_for(resource))
  end
end
