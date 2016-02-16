class LikesController < ApplicationController
	before_action :require_login
	before_action :require_correct_user, only: [:create, :destroy]
	def create
		Like.create(user: User.find(session[:user_id]), secret: Secret.find(params[:secret_id]))
		redirect_to "/secrets"
	end
	def destroy
		Like.where("user_id = ? and secret_id = ?", current_user, params[:secret_id])[0].destroy
		redirect_to "/secrets"
	end
end
