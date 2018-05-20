class DashboardController < ActionController::Base
 	 
 	layout "dashboard"

 	before_action :authenticate_user!

	def home
		@projects = current_user.active_projects + current_user.collaboration_projects.active
	end
end
