class ApiController < ApplicationController
  def username_uniqueness
    user = User.find_by_username params[:username]
    if user then render json: { status: 200 } else render json: { status: 404 } end
  end
end
