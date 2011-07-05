class AuthController < ApplicationController
  skip_before_filter :check_authentication, :only => [:login, :authenticate]
  def login

  end

  def authenticate
    if (user = User.find_by_email(params[:email]).try(:authenticate, params[:password]))
      session[:user_id] = user.id
      redirect_to welcome_auth_path
    else
      flash.now[:alert] = "Email or password incorrect. Please try again."
      render :login
    end
  end

  def welcome
    @projects = current_user.projects
  end

  def logout
    session[:user_id] = nil
    redirect_to login_auth_path
  end
end
