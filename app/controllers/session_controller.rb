class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:session][:username].underscore
    if user and user.authenticate(params[:session][:password])
      #login_user(user)
      redirect_to :root and return
    end

    flash.now[:alert] = t(:incorrect_username_password)
    render :new
  end

  def destroy
  end
end
