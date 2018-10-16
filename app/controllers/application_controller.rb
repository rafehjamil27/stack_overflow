class ApplicationController < ActionController::Base
	# before_action :authorize
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	# after_filter :store_action
  
	# def store_action
	# 	return unless request.get? 
	# 	if (request.path != "/users/sign_in" &&
	# 	    request.path != "/users/sign_up" &&
	# 	    request.path != "/users/password/new" &&
	# 	    request.path != "/users/password/edit" &&
	# 	    request.path != "/users/confirmation" &&
	# 	    request.path != "/users/sign_out" &&
	# 	    !request.xhr?) # don't store ajax calls
	# 	  store_location_for(:user, request.fullpath)
	# 	end
	# end
protected
	
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
			user_params.permit(:email)
		end
	end 

	def authorize
		unless User.find_by(id: session[:user_id])
			redirect_to login_url, notice: "Please log in"
		end
	end
end