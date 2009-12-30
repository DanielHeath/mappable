# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :require_login
  helper_method :logout, :current_user, :logged_in?  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  # Adds an item to the warnings array
  def add_warning(msg)
    w = flash[:warning] ||= []
    flash[:warning] = (w << msg)
  end
  
  def require_login
    redirect_to new_session_path unless logged_in?
    session[:user].reload if session[:user]
  end
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    session[:user]
  end
  
  def logout
    session[:user] = nil
  end

end
