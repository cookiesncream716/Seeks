class SessionsController < ApplicationController
	def new
	end
	def create
		 user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id]= user.id
			session[:user_name] = user.name
			redirect_to "/users/%d" % user.id
		else
			flash[:error] = "Invalid"
			redirect_to "/sessions/new"
		end
	end
	def delete
		session.clear
		redirect_to "/sessions/new"
	end

	
end
