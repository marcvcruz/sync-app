class ApplicationController < ActionController::Base
  include SessionHelper
  protect_from_forgery with: :exception
  before_filter :authenticate

  private

  def authenticate
    redirect_to :sign_in if current_user.nil?
  end

end
