class DepartmentsController < ApplicationController
	before_action :set_department, only: [:show, :edit, :update]
	before_filter :authenticate_user!
	
  def index
    @department = Department.all.order(:id)
  end
  
  def show
  end
  
  def new
    @department = Department.new
  end 

  def create
    @department = Department.new(department_params)
    
    if @department.save
      redirect_to departments_path, notice: "Department successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @department.update(department_params)
			redirect_to departments_path, notice: 'Department successfully updated'
		else
			render action: 'edit'
		end
  end
  
	def destroy
		@department.destroy
		redirect_to departments_path, notice: 'Department successfully deleted'
	end
  
  private
  
	def set_department
		@department = Department.find(params[:id])
	end

	def department_params
		params.require(:department).permit(:name)
	end
end
