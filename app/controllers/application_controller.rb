# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  #Turning off InvalidAuthenticityToken
  #self.allow_forgery_protection = false


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def protect
    if session[:user_id].nil?
      session[:protected_page] = request.request_uri
      flash[:notice] = "please Login."
      redirect_to :action => :login,:controller => :user
      return false
    else      
      @cur_user = User.find_by_id(session[:user_id])
    end
  end
end
