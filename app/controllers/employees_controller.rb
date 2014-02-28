class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update, :destroy]
	before_action :set_organization
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	
  def index
    @search = current_organization.employees.search(params[:q])
    if params[:q].nil?
      @employees = current_organization.employees.order(id: :asc).page(params[:page]).per(5)
    else
      @employees = @search.result.order(id: :asc).page(params[:page]).per(5)
    end
  end
  
  def show
    @employee_claims = @employee.claims.order(date: :asc).page(params[:page]).per(5)
    @employee_leaves = @employee.leaves.order(start_date: :desc).page(params[:page]).per(5)
  end
  
  def new
    @employee = Employee.new
  end 

  def create
    @employee = @organization.employees.new(employee_params)
    if @employee.save
      redirect_to organization_employees_path(@organization), notice: "Employee successfully created"
    else
      render action: 'new', alert: "Please fill in the required field"
    end
  end
  
  def edit

  end
  
  def update
    
		if @employee.update(employee_params)
			redirect_to organization_employees_path(@organization), notice: 'Employee successfully updated'
		else
			render action: 'edit'
		end
  end
  
  def edit_login_info
    @account = Employee.find(params[:employee_id]).account
  end
  
  def update_login_info
    @account = Employee.find(params[:employee_id]).account
    @account.password = params[:account][:password] if !params[:account][:password].blank?
    @account.email = params[:account][:email]
    
    @account_organization = AccountOrganization.where(account_id: @account.id, organization_id: @organization.id).first
    @account_organization.role = params[:account][:role]
		if @account.save && @account_organization.save
			redirect_to organization_employees_path(@organization), notice: 'Account successfully updated'
		else
			redirect_to  organization_employee_edit_login_info_path(@organization, params[:employee_id]), alert: "password must be 8 characters or more"
		end
  end

  def new_login
    @account = Account.new
  end
  
  def create_login
    @account = Account.where(email: params[:account][:email]).first_or_initialize
    @account.password = params[:account][:password]
    
		if @account.save
		  @account_organization = AccountOrganization.new(account_id: @account.id, organization_id: @organization.id, role: params[:account][:role])
		  @account_organization.save
		  
		  employee = Employee.find(params[:employee_id])
		  employee.account_id = @account.id
		  employee.save
		  
			redirect_to organization_employees_path(@organization), notice: 'Login successfully added'
		else
      redirect_to organization_employee_new_login_path(@organization, params[:employee_id]), alert: "Invalid email or password"
		end
  end
  
	def destroy
	  if !@employee.account.blank? && @employee.account.account_organizations.where(organization_id: current_organization).first.role == "Super Admin"
	    redirect_to organization_employees_path(current_organization), alert: 'Super Admin employee cannot be deleted.'
    elsif !@employee.account.blank? && (!Leave.where(action_by_id: @employee.account.id).blank? || !Claim.where(action_by_id: @employee.account.id).blank?)
      redirect_to organization_employees_path(current_organization), alert: 'Employee that has approved leave or claim cannot be deleted.'
	  else
	    @employee.account.destroy if !@employee.account.blank?
		  @employee.destroy
		  redirect_to organization_employees_path(current_organization), notice: 'Employee successfully deleted'
	  end
	end
	
  private
  
	def set_employee
		@employee = Employee.find(params[:id])
	end

	def set_organization
		@organization = Organization.find(params[:organization_id])
	end

	def employee_params
		params.require(:employee).permit(:first_name, :last_name, :mobile_contact, 
		:address, :photo, :properties, :department_ids, :account_id, :position_id, 
		:can_self_approve, :base_salary_cents, :base_salary, :employee_identification)
	end
end
