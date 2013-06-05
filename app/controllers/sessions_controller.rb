class SessionsController < Devise::SessionsController
	
	def index
		super
		@category =Category.all
	end 

	def new
		super
		@category= Category.all
	end


end
