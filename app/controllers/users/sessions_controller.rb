# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # @user = User.find_by(email: params[:user][:email], encrypted_password: params[:user][:password])
    # if @user
    #   if @user || @user.is_active?
    #     if sign_in(@user, event: :authentication) then redirect_to root_url, alert: "Logged in successfully!" 
    #     else redirect_to new_user_session_path, alert: "Invalid user/password combination!" end
    #   else
    #     redirect_to new_user_session_path, alert: "Your account is inactive!"
    #   end
    # end
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
    if !session[:return_to].blank?
      redirect_to session[:return_to]
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
