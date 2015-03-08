module SessionHelper

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
  end
end
