module CurrentUser
	extend ActiveSupport::Concern
private
	def set_user
		# @user = User.find(session[:user_id]) if session[:user_id]
		@user = current_user
	end
end