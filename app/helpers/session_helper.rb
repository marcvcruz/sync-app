module SessionHelper

  def sign_in(user)
    cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
    @current_user = user
  end

  def remember(user)
    user.remember
    cookies.signed[:remember_token] = { value: user.remember_token, expires: 1.month.from_now }
  end

  def sign_out
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def current_user
    @current_user ||= if user_id = cookies.signed[:user_id]
                        user = User.find_by id: user_id
                        user if user and user.authenticated? :remember, cookies.signed[:remember_token]
                      end
  end
end
