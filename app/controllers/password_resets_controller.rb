class PasswordResetsController < ApplicationController
  skip_before_filter :authenticate

  def new
  end

  def create
    @user = User.find_by_email params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t :email_sent_with_password_reset_instructions

    end
  end

  def edit
  end

  def patch
  end
end
