class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  helper_method :signed_in?


	protected

	def current_user
	  return unless session[:user_id]
	  @current_user ||= User.find(session[:user_id])
	end

	def authenticate
	  signed_in? ? true : access_denied
	end

	def signed_in?
	  current_user.is_a? User
	end

	
	def access_denied
		redirect_to login_path, :notice => "Please log in to continue" and return false
	end

end
