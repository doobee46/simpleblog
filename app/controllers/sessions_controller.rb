class SessionsController < ApplicationController

	def create
		if user = User.authenticate(params[:email], params[:password])
			session[:user_id] = user.user_id
			redirect_to root_path, :notice => "Logged in sucessfully"
		else
			flash.now[:alert] ="Invalid login/password combination"
			render :action => 'new'
		end
		
	end
end
