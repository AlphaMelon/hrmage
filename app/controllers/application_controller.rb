class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setup_domains
  helper_method :current_organization
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_can_compability_to_strong_paramater
  before_filter :admin_or_employee_session

  # before_filter :beta

  # def beta
  #   params[:beta] = session[:beta] if session[:beta]
  #   if !params[:beta]
  #     session[:beta] = false
  #     render '/home/coming_soon', layout: 'blank'
  #     return
  #   end
  # end
  
  def admin_or_employee_session
    session[:admin] = true if params[:admin]
    session[:employee] = true if params[:employee]
    if !session[:admin] && !session[:employee]
      session[:employee] = true
    end
  end
  
  def can_can_compability_to_strong_paramater
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:password, :password_confirmation,:current_password)
    end
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_account, current_organization)
  end
  
  def current_organization
    @current_organization
  end

  private
  def setup_domains
    @current_organization = Organization.find_by(domain: request.host)
    if !@current_organization
      @current_organization = Organization.new
      if Rails.env.production?
        redirect_to host: "officemage.com" if request.host != "officemage.com"
      else
        redirect_to host: "hrmage.dev", port: request.port if request.host != "hrmage.dev"
      end
    end
  end
end
