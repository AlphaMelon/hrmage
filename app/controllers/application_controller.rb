class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setup
  helper_method :current_organization
  helper_method :current_employee
  helper_method :working_hours
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_can_compability_to_strong_paramater
  before_filter :admin_or_employee_session
  
  include PublicActivity::StoreController

  def admin_or_employee_session
    session[:admin_session] = true if params[:admin_session]
    session[:admin_session] = false if params[:employee_session]
    session[:employee_session] = true if params[:employee_session]
    session[:employee_session] = false if params[:admin_session]
    if !session[:admin_session] && !session[:employee_session]
      session[:employee_session] = true
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
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, 
                                                    :password_confirmation) }
  end
  
  def working_hours
    if current_organization.organization_setting.nil? 
      return 8.0 
    else
      return current_organization.organization_setting.average_working_hour.to_f
    end
  end
  
  def current_ability
    @current_ability ||= ::Ability.new(current_account, current_organization)
  end
  
  def current_organization
    @current_organization
  end
  
  def current_employee
    Employee.where(account_id: current_account.id, organization_id: current_organization).first
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end
  

  
  private
  def setup
    @current_organization = ::Organization.find_by(domain: request.host)
    if !@current_organization
      @current_organization = ::Organization.new
      if Rails.env.production?
        redirect_to host: "officemage.com" if request.host != "officemage.com"
      else
        redirect_to host: "hrmage.dev", port: request.port if request.host != "hrmage.dev"
      end
    end
  end
  

end
