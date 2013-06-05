class UsersController < ApplicationController
    def index
    	@user =User.all
    	@category = Category.all	
    end

    def show
     @user = User.find(params[:id])
    end
	
end
