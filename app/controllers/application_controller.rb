class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_app_auth

  def check_app_auth()
    if params.has_key?('auth_login') and params.has_key?('auth_password')
      if User.check_user(params['auth_login'], params['auth_password'])
        session[:user] = params['auth_login'] 
      end 
    end  
    if session[:user].nil?
      redirect_to(:controller => :nobody, :action => :login)
    else
      @current_user = session[:user]
      @current_user_object = User.where(user_login: @current_user).first
      
      unless @current_user_object.nil?
        unless check_ctr_auth()
          redirect_to(:controller => :nobody, :action => :access_denied,
            :bad_action_name => action_name,
            :bad_controller_name => controller_name,
            :bad_user_name => @current_user)
        end
      else
        redirect_to(:controller => :nobody, :action => :access_denied,
          :bad_action_name => action_name,
          :bad_controller_name => controller_name,
          :bad_user_name => @current_user)
      end  
    end
  end
  
  private
  def check_ctr_auth()
    return true if @current_user_object.is_admin?
    return false
  end
end
