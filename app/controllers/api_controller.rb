class ApiController < ApplicationController
  def username_uniqueness
    user = User.find_by_username params[:username]
    if user then render json: { result: 200 } else render json: { result: 404 } end
  end
end
