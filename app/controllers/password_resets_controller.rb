class PasswordResetsController < ApplicationController
  include SessionHelper

  skip_before_filter :authenticate
  before_filter :get_user, only: [:edit, :update]
  before_filter :validate_user, only: [:edit, :update]
  before_filter :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by_username params[:password_reset][:username].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
    end
  end

  def edit
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.valid? and @user.save
      sign_in @user
      remember @user
      redirect_to :root and return
    end
    render :edit
  end

  private

  def get_user
    @user = User.find_by_username params[:username]
  end

  def validate_user
    unless @user and @user.authenticated? :reset, params[:token]
      flash[:alert] = t :error_occurred_during_authentication
      redirect_to new_password_reset_path
    end
  end

  def check_expiration
    if @user.reset_sent_at.advance(hours: 24).past?
      flash[:alert] = t :password_reset_token_expired
      redirect_to new_password_reset_path
    end
  end
end
