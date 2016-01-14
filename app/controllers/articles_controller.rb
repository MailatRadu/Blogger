class ArticlesController < ApplicationController
	before_filter :require_login, except: [:show, :index, :show_by_month, :show_by_popularity]
	include ArticlesHelper
	def index
		@articles = Article.all
	end
	def show
		@article = Article.find(params[:id])
		@article.view_count += 1 #or @article.increment_view_count -> function in article.rb
		@article.save
		@comment = Comment.new
		@comment.article_id = @article_id
	end
	def new
		@article = Article.new
	end
	def edit
		@article = Article.find(params[:id])
	end
	def create
		@article = Article.new(article_params)
		@article.view_count = 0;
		@article.save

		flash.notice = "Article '#{@article.title}' Created!"

		redirect_to article_path(@article)
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "Article '#{@article.title}' Deleted"

		redirect_to articles_path
	end
	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end

	def show_by_month
		@articles = Article.all.select{|a| a.created_at.month == params[:month].to_i}
	end

	def show_by_popularity
		@articles = Article.all.order(view_count: :desc).limit(5)
	end
end

