class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy] 

  def index
  	@secrets = Secret.all
  end
  def create
  	Secret.create(content: params[:new_secret], user: User.find(session[:user_id]))
  	redirect_to "/users/%d" % session[:user_id]
  end
 
  def destroy
  	secret = Secret.find(params[:id])
  	secret.destroy if secret.user == current_user
  	redirect_to "/users/%d" % session[:user_id]
  end
end
