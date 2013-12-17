class EmployeeDepartmentsController < ApplicationController
	before_action :set_employee
	before_action :set_organization
	before_action :set_employee_department, only: [:destroy]
	before_filter :authenticate_account!
	
  def new
    @employee_department = EmployeeDepartment.new
    @departments = @organization.departments
  end 

  def create
    @employee_department = EmployeeDepartment.new(employee_department_params)
    @employee_department.employee_id = @employee.id
    if @employee_department.save
      redirect_to edit_organization_employee_path(@organization, @employee), notice: "Department successfully linked"
    else
      render action: 'new'
    end
  end
  
  def destroy
    @employee_department.delete
    redirect_to edit_organization_employee_path(@organization, @employee), notice: "Department link removed from employee"
  end
  
  private
  
	def set_employee
		@employee = Employee.find(params[:employee_id])
	end

	def set_organization
		@organization = Organization.find(params[:organization_id])
	end
	
	def set_employee_department
		@employee_department = EmployeeDepartment.find(params[:id])
	end
	
	def employee_department_params
		params.require(:employee_department).permit(:employee_id, :department_id, :leader)
	end
end
