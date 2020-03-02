class ApplicationController < ActionController::Base
  helper_method :is_logged_in?, :current_user

  def is_logged_in?
    session[:token].present?
  end

  def current_user
    session[:user]
  end
end
