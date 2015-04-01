class PasswordResetsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :get_user, only: [:edit, :update]
  before_filter :validate_user, only: [:edit, :update]
  before_filter :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by_email params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
    end
  end

  def edit
  end

  def patch
  private

  def get_user
    @user = User.find_by_email params[:email]
  end

  def validate_user
    unless @user and @user.authenticated? :reset, params[:token]
      redirect_to new_password_reset_url
    end
  end

  def check_expiration
    if @user.reset_sent_at.advance(hours: 24).past?
      flash[:alert] = t :password_reset_token_expired
      redirect_to new_password_reset_url
    end
  end
end
