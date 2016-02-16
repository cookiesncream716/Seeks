class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def show
		@user = User.find(session[:user_id])
		@secrets = User.find(session[:user_id]).secrets
		@secrets_liked = Secret.select("*").joins(:likes).where("likes.user_id = ?", (session[:user_id]))
	end
	def new
	end
	def create
		@user = User.new(name: params[:name], email: params[:email], password: params[:password])
		if @user.valid? ==true
			@user.save
			session[:user_id] = @user.id
			session[:user_name] = @user.name
			redirect_to "/users/%d" % @user.id
		else
			flash[:mistakes] = @user.errors.full_messages
			redirect_to "/users/new"
		end
	end
	def edit 
		@user = User.find(session[:user_id])
	end
	def update
		@user = User.find(session[:user_id])
		@user.update_attributes(name: params[:name], email: params[:email], password: params[:password])
		redirect_to "/users/%d" % @user.id
	end
	def destroy
		@user = User.find(session[:user_id]).destroy
		session.clear
		redirect_to "/sessions/new"
	end
end

