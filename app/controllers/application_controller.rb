class ApplicationController < ActionController::Base
  helper_method :current_user, :log_in

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
