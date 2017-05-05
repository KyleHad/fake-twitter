class UsersController < ApplicationController
	before_action :get_user, only: [:destroy, :show]
	before_action :check_auth, only: [:destroy]

	def get_user
		@user = User.find(params[:id])
	end

	def check_auth
		if session[:user_id] != @user
		flash[:notice] = " "
		end
	end

	def show
	end

	def new
  	@user = User.new
	end

	def create
  	@user = User.new(user_params)
  	if @user.save
    	redirect_to root_url, :notice => "Signed up!"
  	else
    	render "new"
  	end
	end

	def destroy
		@current_user = nil
		session[:user_id] = nil
		@user.destroy
		redirect_to root_url
	end

	def user_params
		params.require(:user).permit(:name, :password, :password_hash, :password_salt)
	end
end
