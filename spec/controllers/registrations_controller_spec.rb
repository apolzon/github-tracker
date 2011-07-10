require 'spec_helper'

describe RegistrationsController do
  render_views
  describe "#new" do
    it "displays a form" do
      get :new
      response.should be_success
      response.should have_tag "form"
      assigns(:user).should be_a User
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, {:user => {:name => "me", :email => "a@a.com", :password => "asdf", :password_confirmation => "asdf"}}
        }.to change(User, :count).by(1)
        response.should redirect_to login_auth_path
      end

    end
    context "with invalid param" do
      it "does not create a new user" do
        expect {
          post :create, {:user => {:name => "", :email => "", :password => "bunk", :password_confirmation => "bunker"}}
        }.to change(User.all, :count).by(0)
      end
      it "re-renders the registration form with errors" do
        post :create, {:user => {:name => "", :email => "", :password => "", :password_confirmation => ""}}
        response.body.should have_content "Registration failed."
        response.body.should have_content "Name can't be blank"
        response.body.should have_content "Email can't be blank"
        response.body.should have_content "Password can't be blank"
      end
      it "verifies confirmation of password" do
        post :create, {:user => {:name => "asdf", :email => "a@a.com", :password => "asdf", :password_confirmation => "asd2"}}
        response.body.should have_content "doesn't match confirmation"
      end
      it "require verifications of password" do
        post :create, {:user => {:name => "asdf", :email => "a@a.com", :password => "asdf"}}
        response.body.should have_content "can't be blank"
      end

    end
  end

end
