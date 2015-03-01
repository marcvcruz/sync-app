class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate

  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
  end

  private

  def authenticate
    redirect_to :sign_in if current_user.nil?
  end

end
