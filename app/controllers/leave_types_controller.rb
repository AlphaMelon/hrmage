class LeaveTypesController < ApplicationController
	before_action :set_organization
	before_action :set_leave_type, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  def index
    @leave_types = current_organization.leave_types.all
  end
  
  def new
    @leave_type = current_organization.leave_types.new
  end 

  def create
    @leave_type = LeaveType.new(leave_type_params)
    @leave_type.affected_entity = leave_type_params[:affected_entity].delete('\"').split(',')
    @leave_type.organization_id = current_organization.id
    if @leave_type.save
      redirect_to organization_leave_types_path(current_organization), notice: "Leave type successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @leave_type.update(leave_type_params)
		  @leave_type.affected_entity = leave_type_params[:affected_entity].delete('\"').split(',')
		  @leave_type.save
			redirect_to organization_leave_types_path(current_organization), notice: 'Leaves type succesfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
		@leave_type.destroy
		redirect_to organization_leave_types_path(current_organization), notice: 'Leave type successfully deleted'
	end

  private
	
	def set_leave_type
	  @leave_type = LeaveType.find(params[:id])
	end

	def set_organization
	  @organization = Organization.find(params[:organization_id])
	end

	def leave_type_params
	  if !params[:leave_substraction].nil?
	    params.require(:leave_substraction).permit(:name, :description, :affected_entity, :type)
		elsif !params[:leave_neutral].nil?
		  params.require(:leave_neutral).permit(:name, :description, :affected_entity, :type)
		elsif !params[:leave_addition].nil?
		  params.require(:leave_addition).permit(:name, :description, :affected_entity, :type)
		else
		  params.require(:leave_type).permit(:name, :description, :affected_entity, :type)
		end
	end
end
