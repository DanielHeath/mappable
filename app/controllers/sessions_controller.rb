# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  # POST sessions/create
  # POST login
  def create
    session[:user] = User.login_or_signup(params[:session])
    if logged_in?
      redirect_to('/')
      flash[:notice] = "Logged in successfully"
    else
      add_warning "Bad username/password combination! Please try again."
      render :action => 'new'
    end
  end

  # GET sessions/destroy
  # GET logout
  def destroy
    logout
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to('/')
  end
  
end
