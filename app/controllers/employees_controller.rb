class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update]
	before_action :set_organization
	before_filter :authenticate_account!
	
  def index
    @employees = @organization.employees.order(:id)
  end
  
  def show
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
    @user = Employee.find(params[:employee_id]).user
    authorize! :manage, @user
  end
  
  def update_login_info
    @user = Employee.find(params[:employee_id]).user
    authorize! :manage, @user
    @user.password = params[:user][:password] if !params[:user][:password].blank?
    @user.email = params[:user][:email]
    @user.role = params[:user][:role]
		if @user.save
			redirect_to organization_employees_path(@organization), notice: 'User successfully updated'
		else
			render action: 'edit'
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
		:address, :photo, :properties, :department_ids)
	end
end
