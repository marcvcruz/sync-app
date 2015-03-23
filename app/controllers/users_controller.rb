class UsersController < ApplicationController
  before_filter do
    redirect_to :root unless current_user.is_admin
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    redirect_to users_path and return if @user.save
    render :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find params[:id]
    redirect_to users_path and return if @user.update update_user_params
    render :edit
  end
  private

    def create_user_params
      params.require(:user).permit!
    end

    def update_user_params
      params.require(:user).permit(:first_name, :last_name, :email, :is_admin)
    end
end
