class SessionController < ApplicationController
  skip_before_filter :authenticate, except: :destroy

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user and user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to :root and return
    end

    flash.now[:alert] = t(:incorrect_username_password)
    render :new
  end


  def destroy
    session[:user_id] = nil
    redirect_to :sign_in
  end
end
