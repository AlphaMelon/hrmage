class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setup_domains
  helper_method :current_organization
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:password, :password_confirmation,:current_password)
    end
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
  end
  
  def after_sign_in_path_for(resource)
    if request.host == "localhost" || request.host == "hrmage.com" || request.host.nil?
    
      if resource.organizations.count != 0 #account with at least one organization
        resource.organizations.first.domain
      else
        root_path #account with 0 organizations
      end
      
    else
      root_path #user already in his own domain
    end
  end
  
  def current_organization
    @current_organization
  end

  private
  def setup_domains
    @current_organization = Organization.find_by(domain: request.host)
    if !@current_organization
      @current_organization = Organization.new
    end
  end
end
