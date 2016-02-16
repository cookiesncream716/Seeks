require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	before do
		@user = create_user
		@secret = @user.secrets.create(content: "secret")

	end
	describe "when not logged in" do
		before do
			session[:user_id] = nil
		end
		it "cannot access create" do
			post :create
			expect(response).to redirect_to("/sessions/new")
		end
		it "cannot access destroy" do
			delete :destroy, id: @secret
			expect(response).to redirect_to("/sessions/new")
		end
	end
	describe "when signed in as the wrong user" do
		before do
			@wrong_user = create_user "wrong", "wrong@gmail.com"
			session[:user_id] = @wrong_user.id
		end
		pending "cannot create a like" do
			post :create, user_id: @wrong_user, secret_id: @secret
			expect(response).to redirect_to("/secrets")
		end
		pending "cannot destroy a like" do
			delete :destroy, user_id: @wrong_user, secret_id: @secret
			expect(response).to redirect_to("/secrets")
		end
	end

end
