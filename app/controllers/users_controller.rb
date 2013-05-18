class UsersController < ApplicationController
   def new 
   	 @user = User.new
   	 @category = Category.all
   end

   def create
   	 @user = User.new(params[:user])
   	 @category = Category.all
   	 if @user.save
   	 	redirect_to articles_path, :notice => "User succesfully added."
   	 else 
   	 	render :action => 'new '
   	 end 
   end 

   	def edit
   	  @user= User.find(params[:id])
   	  @category = Category.all
    end 

    def update
      @user = User.find(params[:id])
      @category = Category.all
      if @user.update_attributes(params[:user])
      	redirect_to articles_path, :notice => 'Updated user information succesfully'
      else
      	render :action => 'edit'
      end
    end
end
