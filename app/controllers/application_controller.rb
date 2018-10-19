class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  load_and_authorize_resource

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, :alert => exception.message
  end
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, :alert => 'Resource doesn\'t exist' }
    end
  end

protected
	
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
			user_params.permit(:email)
		end
	end 

end