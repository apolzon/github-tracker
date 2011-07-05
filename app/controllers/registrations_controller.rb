class RegistrationsController < ApplicationController
  skip_before_filter :check_authentication

  def new
  end

  def create
  end
end
