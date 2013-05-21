class PagesController < ApplicationController
	
	def admin
	  @articles = Article.order("published_at desc").page(params[:page]).per_page(5)
	end

	
end
