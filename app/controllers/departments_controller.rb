class DepartmentsController < ApplicationController
	before_action :set_department, only: [:show, :edit, :update]
	before_action :set_organization
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	
  def index
    @departments = @organization.departments.order(:id)
  end
  
  def show
  end
  
  def new
    @department = @organization.departments.new
  end 

  def create
    @department = @organization.departments.new(department_params)
    
    if @department.save
      redirect_to organization_departments_path(@organization), notice: "Department successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @department.update(department_params)
			redirect_to organization_departments_path(@organization), notice: 'Department successfully updated'
		else
			render action: 'edit'
		end
  end
  
	def destroy
		@department.destroy
		redirect_to organization_departments_path(@organization), notice: 'Department successfully deleted'
	end
  
  private
  
	def set_department
		@department = Department.find(params[:id])
	end
	
	def set_organization
		@organization = Organization.find(params[:organization_id])
	end
	
	def department_params
		params.require(:department).permit(:name)
	end
end
