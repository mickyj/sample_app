module SessionsHelper

  def sign_in(user)
      #first create a new token
      remember_token = User.new_remember_token
      #second place raw token on browser cookies
      cookies.permanent[:remember_token] = remember_token
      #third - save the hashed version of the token to the database
      user.update_attribute(:remember_token, User.digest(remember_token))
      #fourth - set current user equal to the given user
      self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

   def signed_in?
    !current_user.nil?
  end

  def sign_out
    #change users remember token in DB (incase cookie has been stolen)
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    #delete method to remove the remember token from this session
    cookies.delete(:remember_token)
    #set current user to nil
    self.current_user = nil
  end
end