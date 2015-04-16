class PasswordUpdatesController < ApplicationController

  def edit
  end

  def update
    unless current_user.authenticate params[:password_update][:current_password]
      flash.now[:alert] = t 'errors.messages.wrong_password'
      render :edit and return
    end

    current_user.password = update_password_params[:password]
    current_user.password_confirmation = update_password_params[:password_confirmation]
    if current_user.save
      flash[:notice] = t :password_successfully_changed
      redirect_to users_path and return
    end

    flash[:alert] = t 'error_occurred_processing_last_request'
    render :edit
  end

  private

  def update_password_params
    params.require(:password_update).permit(:password, :password_confirmation)
  end
end
