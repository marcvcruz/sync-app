class PasswordUpdatesController < ApplicationController

  def edit
  end

  def update
    current_user.password = nil
    if current_user.update_attributes update_password_params
      flash[:notice] = t :password_successfully_changed
      redirect_to users_path and return
    end
    render :edit
  end

  private

  def update_password_params
    params.require(:password_update).permit(:password, :password_confirmation)
  end
end
