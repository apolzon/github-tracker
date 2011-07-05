class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_authentication
  helper_method :current_user

  def current_user
    @@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_authentication
    @@current_user = current_user
    redirect_to login_auth_path unless current_user
  end
end
