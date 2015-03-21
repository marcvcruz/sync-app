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

  end
end
