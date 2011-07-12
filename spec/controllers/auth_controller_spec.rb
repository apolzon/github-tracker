require 'spec_helper'

describe AuthController do
  render_views
  describe "#login" do
    it "shows the login form" do
      get :login
      response.should be_success
      response.should have_tag "form"
      response.body.should have_content "Login"
      response.should have_tag :h1, "Login"
    end
    it "has a link to the registration page" do
      get :login
      response.should have_tag "a", "click here to register"
    end
  end
  describe "#authenticate" do
    it "logs the user in" do
      user = Factory :user, :password => "asdf", :password_confirmation => "asdf"
      post :authenticate, :email => user.email, :password => "asdf"
      response.should redirect_to(welcome_auth_path)
    end
  end
  describe "#welcome" do
    context "while logged in" do
      it "displays the users projects" do
        user = Factory :user, :password => "asdf", :password_confirmation => "asdf"
        project = Factory :github_project, :user => user
        project2 = Factory :pivotal_project, :user => user
        post :authenticate, :email => user.email, :password => "asdf"
        get :welcome
        response.should be_success
        response.body.should have_content "#{user.email}"
        response.body.should have_content "Your Projects"
        response.body.should have_content "#{project.name}"
        response.body.should have_content "#{project2.name}"
      end
    end
    context "while logged out" do
      it "redirects to login" do
        get :welcome
        response.should redirect_to login_auth_path
      end
    end
  end
  describe "#logout" do
    it "logs the user out" do
      user = Factory :user, :password => "asdf", :password_confirmation => "asdf"
      post :authenticate, :email => user.email, :password => "asdf"
      delete :logout, :id => user.id
      get :welcome
      response.should redirect_to login_auth_path
    end
  end
end
