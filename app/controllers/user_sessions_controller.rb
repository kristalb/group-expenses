# This controller handles the login/logout function of the site.  
class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @session = UserSession.new
  end

  def create
    @session = UserSession.new(params[:user_session])
    if @session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default users_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end
end
