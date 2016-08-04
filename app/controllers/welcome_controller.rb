class WelcomeController < ApplicationController
skip_before_filter :authenticate_user!, only: [ :index ]
layout :set_layout
	
	def index
		# binding.pry
		@approved_articles = Article.where(status: 2)
	end	

	def dashboard
		# @articles = Article.where(status: 2)
	end

	private

	def set_layout
		if user_signed_in?
			if current_user.admin?
				"admin_layout"
			else
				"user_layout"
			end
		end
	end

end
