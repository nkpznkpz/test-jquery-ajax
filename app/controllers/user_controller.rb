class UserController < ApplicationController
  before_filter :protect,:only =>[:index,:show]
  #protect_from_forgery :except => [:create,:chk_email_ajax]
  def index

  end
  def show
  end
  def create
    if request.xhr? && !params[:name].blank? && !params[:lastname].blank? && !params[:email].blank? && !params[:password].blank?
      if(chk_email(params[:email]))
        User.create() { |u|
          u.name  = params[:name]
          u.lastname = params[:lastname]
          u.email = params[:email]
          u.password = params[:password]
        }
        render :text => :success
      else
        render :text => :error
      end
    else
      redirect_to :action => :index,:controller => :task_group
    end
  end

  def update
  end
  
  def login_page
  end

  def login
    if session[:user_id]
      redirect_to :action => :index,:controller => :user
    else
      if !params['txtPassword'].blank? && !params['txtEmail'].blank?
        @users = User.find_by_email_and_password(params['txtEmail'],params['txtPassword'])
        if @users
          session[:user_id] = @users.id
          #friendly url
          p = session[:protected_page]
          if p
            redirect_to p
          else
            redirect_to :action => :index,:controller => :task
          end
        end
        #       flash[:notice] = "oksss"
      end
    end    
  end   
    
  def logout
    reset_session
    session[:user_id] = nil
    redirect_to :action=>:login,:controller=>:user
  end

  def chk_email_ajax
    validate_arr = [params[:validateId],params[:validateError]]

    if User.find_by_email(params[:validateValue]).nil?
      validate_arr << :true
      
    else
      validate_arr << :false
    end
    render :text => '{"jsonValidateReturn":'+validate_arr.to_json+'}'
  end
  private
  def chk_email(email)
    if User.find_by_email(email).nil?
      return true
    else
      return false
    end
  end

end
