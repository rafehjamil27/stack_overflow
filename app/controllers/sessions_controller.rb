class SessionsController < ApplicationController

	skip_before_action :authorize

	def new

	end

	def create
		@user = User.find_by(email: params[:email])
		if sign_in @user, event: :authentication
			# session[:user_id] = user.id
			# session[:is_admin] = user.is_admin if user.is_admin == true
			redirect_to questions_url, alert: "Logged in successfully!"
		else
			redirect_to login_url, alert: "Invalid user/password combination! #{params[:password]}"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end
