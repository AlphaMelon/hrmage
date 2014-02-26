class EmployeeVariablesController < ApplicationController
	before_action :set_employee
	before_action :set_employee_variable, only: [:show, :edit, :update]
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	
  def index
    current_organization.leave_types.each do |leave_type|
      EmployeeVariable.where(employee_id: @employee.id, leave_type_id: leave_type.id).first_or_create
    end
    @employee_variables = @employee.employee_variables.all
  end
  
  def edit

  end
  
  def update
    @employee_variable.available_leaves_seconds = employee_variables_params[:available_leaves_seconds].to_i*24*60*60
		if @employee_variable.save
			redirect_to organization_employee_employee_variables_path(current_organization, @employee), notice: "Employee's settings successfully updated"
		else
			render action: 'edit'
		end
  end

  private
  
	def set_employee_variable
		@employee_variable = EmployeeVariable.find(params[:id])
	end

	def set_employee
		@employee = Employee.find(params[:employee_id])
	end

	def employee_variables_params
		params.require(:employee_variable).permit(:employee_id, :leave_type_id, :available_leaves_seconds)
	end
end
