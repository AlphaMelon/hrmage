class OrganizationsController < ApplicationController
	before_action :set_organization, only: [:show, :edit, :update]
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	
	def index
	  @organizations = current_account.organizations
	end
  
  def show
  end
  
  def new
    @organization = Organization.new
  end 

  def create
    @organization = Organization.new(organization_params)
    if Rails.env == "development" || Rails.env == "test"
      @organization.domain = (@organization.name.downcase.delete(" ") + ".hrmage.dev")
    elsif Rails.env == "production"
      @organization.domain = (@organization.name.downcase.delete(" ") + ".officemage.com")
    end
    if @organization.save
    
      account_organization = AccountOrganization.new
      account_organization.organization_id = @organization.id
      account_organization.account_id = current_account.id
      account_organization.role = "Admin"
      account_organization.save
      
      redirect_to organization_path(@organization), notice: "Organization successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  
  end
  
  def update
		@organization.assign_attributes(organization_params)
    
		if @organization.save
			redirect_to organization_path(@organization), notice: 'Organization successfully updated'
		else
			render action: 'edit'
		end
  end
  
  def end_of_year_action
    authorize! :manage, current_organization
    
    current_organization.employees.each do |employee|
      current_organization.leave_types.each do |leave_type|
        employee_variable = EmployeeVariable.where(employee_id: employee.id, leave_type_id: leave_type.id).first_or_create
        default_max_leave = 0
        if employee.position.position_settings.where(leave_type_id: leave_type.id).blank?
          default_max_leave = employee.position.position_settings.where(leave_type_id: leave_type.id).first.max_leaves_seconds
        else
          default_max_leave = leave_type.default_count_seconds
        end
        
        if params[:forfeit]
          employee_variable.available_leaves_seconds = default_max_leave
        elsif params[:forward]
          employee_variable.available_leaves_seconds = employee_variable.available_leaves_seconds + default_max_leave
        end
        employee_variable.save
      end
    end

    if params[:forfeit]
      redirect_to organization_leaves_path(current_organization), notice: "Employee's leaves reseted"
    else
      redirect_to organization_leaves_path(current_organization), notice: "Employee's leaves forwarded"
    end
  end
  
  private
  
	def set_organization
		@organization = Organization.find(params[:id])
	end

	def organization_params
		params.require(:organization).permit(:name, :domain, :default_currency, :country, :time_zone)
	end
end
