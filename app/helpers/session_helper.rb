module SessionHelper
  def current_user
    User.find(session[:user])
  end

  def current_user_set(id)
    session[:user] = id
  end
end
