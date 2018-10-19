module UsersHelper
	def active_checkbox(user)
		if user.is_active?
			if user.is_admin? 
				"<input data-user-id='#{user.id}' class='admin-checkbox' type='checkbox' checked disabled>"
			else 
				"<input data-user-id='#{user.id}' class='admin-checkbox' type='checkbox' checked>" 
			end
		else
			"<input data-user-id='#{user.id}' class='admin-checkbox' type='checkbox'>"
		end
	end
end
