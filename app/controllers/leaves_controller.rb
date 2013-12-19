class LeavesController < ApplicationController
	before_action :set_organization
	before_action :set_leave, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  def index
    @pending_leaves = @organization.leaves.where(status: "Pending")
    @approved_leaves = @organization.leaves.where(status: "Approved")
    @rejected_leaves = @organization.leaves.where(status: "Rejected")
  end
  
  def new
    @leave = current_organization.leaves.new
  end 

  def create
    @leave = current_organization.leaves.new(leave_params)
    @leave.employee_id = current_account.profile.id
    if @leave.save
      redirect_to my_leaves_path, notice: "Leave successfully applied, please wait for admin to approve"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @leave.update(leave_params)
			redirect_to organization_leaves_path(current_organization), notice: 'Leaves status changed'
		else
			render action: 'edit'
		end
  end

	def destroy
		@leave.destroy
		redirect_to leaves_path, notice: 'Leave successfully deleted'
	end

  private
	
	def set_leave
	  @leave = Leave.find(params[:id])
	end

	def set_organization
	  @organization = Organization.find(params[:organization_id])
	end

	def leave_params
		params.require(:leave).permit(:start_date, :end_date, :comment, :leave_type, :status)
	end
end
