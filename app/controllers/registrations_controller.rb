class RegistrationsController < ApplicationController
  skip_before_filter :check_authentication

  def new
    @user = User.new
  end

  def create
    if User.find_by_email(params[:user][:email])
      flash[:error] = "E-mail already taken..."
      redirect_to login_auth_path
    else
      @user = User.new params[:user]
      if @user.save
        flash[:notice] = "Registered successfully. Please login."
        redirect_to login_auth_path
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :new
      end
    end
  end
end
