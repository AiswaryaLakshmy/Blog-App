class WelcomeController < ApplicationController

	
	def index
		@articles = Article.all
	end

	def dashboard
		if user_signed_in?
			if current_user.has_role? :admin
				render layout: "admin_layout"
			else
				render layout: "user_layout"
			end
		else
			redirect_to new_user_session_path
		end
	end


end
