class SessionController < ApplicationController
  skip_before_filter :authenticate, except: :destroy

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user and user.authenticated?(:password, params[:session][:password])
      sign_in user
      remember user
      redirect_to :root and return
    end

    flash.now[:alert] = t(:incorrect_username_password)
    render :new
  end


  def destroy
    sign_out
    redirect_to :sign_in
  end
end
