require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "Post #create" do
    context "with valid params" do
      it "creates a user" do
        post :create, user: {username: "UserFace", password: "password" }
        expect(response).to redirect_to(goals_url)
      end
    end

    context "with invalid params" do
      it "renders new with error messages" do
        post :create, user: {username: "d", password: "" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end


end
