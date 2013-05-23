class PagesController < ApplicationController
	before_filter :authenticate_user!
	
	def admin
	  @articles = Article.order("published_at desc").page(params[:page]).per_page(5)
	  @users =User.all
	end

	
end
