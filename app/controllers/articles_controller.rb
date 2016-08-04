class ArticlesController < ApplicationController
	before_action :get_article, only: [ :show, :edit, :update, :destroy, :submit_to_admin, :approved_by_admin, :rejected_by_admin ]
	skip_before_filter :authenticate_user!, only: [ :show ]

	layout :get_layout
	# layout 'user_layout', except: [ :admin_articles]
	# layout 'admin_layout', only: [ :admin_articles ]

	def index
		if current_user.user?
			@articles = current_user.articles
		else
			redirect_to root_path
		end
	end

	def show
		
	end

	def new
		if current_user.user?
			@article = Article.new
		else
			redirect_to root_path
		end	
	end

	def edit
		
	end

	def create
		if current_user.user?
			@article = current_user.articles.new(article_params)
			if @article.save
				@article.update(status: :active)
				redirect_to articles_path
			else
				render 'new'
			end
		else
			redirect_to root_path
		end
	end

	def update

		if @article.update(article_params)
			redirect_to @article

		else 
			render 'edit'
		end
	end

	def destroy
  	@article.destroy
  	redirect_to articles_path
	end

	def submit_to_admin
		@article.update(status: :pending)
		redirect_to articles_path
	end

	def approved_by_admin
		@article.update(status: :approved)
		redirect_to admin_articles_path
	end

	def rejected_by_admin
		@article.update(status: :rejected)
		redirect_to admin_articles_path
	end

	def admin_articles
		if current_user.admin?
			@pending_articles = Article.where(status: 1)
			@approved_articles = Article.where(status: 2)
			@rejected_articles = Article.where(status: 3)
		else
			redirect_to root_path
		end
	end

	private

		def get_article
			@article = Article.find(params[:id])
		end

		def article_params
			params.require( :article ).permit(:title, :text )
		end

	def get_layout
		if user_signed_in?
			if current_user.admin?
				"admin_layout"
			else
				"user_layout"
			end
		end
	end

end
