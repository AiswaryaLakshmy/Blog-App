class WelcomeController < ApplicationController
skip_before_filter :authenticate_user!, only: [ :index ]
	
	def index
		@approved_articles = Article.where(status: 2)
	end

	def dashboard
		# @articles = Article.where(status: 2)
		if user_signed_in?
			if current_user.admin?
				render layout: "admin_layout"
			else
				render layout: "user_layout"
			end
		end
	end


end
