class Admin::EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!
	
  def index
    @employees = Employee.all
  end
  def show
  end
  
  def new
  end 

  def create
  end
  
  private
  
	def set_employee
		@employee = Employee.find(params[:id])
	end

	def employee_params
		params.require(:employee).permit(:first_name, :last_name, :mobile_contact, :address, :properties)
	end
end
