class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update]
	before_filter :authenticate_user!
	
  def index
    @employees = Employee.all.order(:id)
  end
  
  def show
  end
  
  def new
    @employee = Employee.new
  end 

  def create

    @user = User.where(email: params[:email]).first_or_initialize
    @user.password = params[:password]
    @user.role = params[:role]
    @user.save
    
    @employee = Employee.new(employee_params)
    @employee.user = @user
    
    if @employee.save
      redirect_to employees_path, notice: "Employee successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @employee.update(employee_params)
			redirect_to employees_path, notice: 'Employee successfully updated'
		else
			render action: 'edit'
		end
  end
  
  def edit_login_info
    @user = Employee.find(params[:employee_id]).user
  end
  
  def update_login_info
    @user = Employee.find(params[:employee_id]).user
    @user.password = params[:user][:password] if !params[:user][:password].blank?
    @user.email = params[:user][:email]
    @user.role = params[:user][:role]
    
		if @user.save
			redirect_to employees_path, notice: 'User successfully updated'
		else
			render action: 'edit'
		end
		
  end
  
  private
  
	def set_employee
		@employee = Employee.find(params[:id])
	end

	def employee_params
		params.require(:employee).permit(:first_name, :last_name, :mobile_contact, 
		:address, :photo, :properties, :department_id)
	end
end
