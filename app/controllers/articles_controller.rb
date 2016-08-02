class ArticlesController < ApplicationController
	before_action :get_article, only: [ :show, :edit, :update, :destroy ]
	
	# def index
	# 	@articles = Article.all	
	# end

	def show
		
	end

	def new
		@article = Article.new
	end

	def edit
		
	end

	def create
		@article = Article.new(article_params.merge(user_id: current_user.id))

		if @article.save
			redirect_to @article
		else
			render 'new'
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

	private

		def get_article
			@article = Article.find(params[:id])
		end

		def article_params
			params.require( :article ).permit(:title, :text )
		end

end
