class LeavesController < ApplicationController
	before_action :set_organization
	before_action :set_leave, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
	
	load_and_authorize_resource
  
  def index
    @pending_leaves = @organization.leaves.where(status: "Pending")
    @approved_leaves = @organization.leaves.where(status: "Approved")
    @rejected_leaves = @organization.leaves.where(status: "Rejected")
    
    @month = !params[:date][:month].blank? ? params[:date][:month].to_i : DateTime.now.month
    @year = !params[:date][:year].blank? ? params[:date][:year].to_i : DateTime.now.year
    @date = DateTime.new(@year, @month)
    @month_collection = [
    ["January", 1], 
    ["February", 2], 
    ["March", 3], 
    ["April", 4], 
    ["May", 5], 
    ["June", 6], 
    ["July", 7], 
    ["August", 8], 
    ["September", 9], 
    ["October", 10], 
    ["November", 11], 
    ["December", 12]]
    
    @employees = current_organization.employees.order(:id)
    
    #raise params.inspect
  end
  
  def new
    @leave = current_organization.leaves.new
    @leave_types = current_organization.leave_types.all
  end 

  def create
    @leave = current_organization.leaves.new(leave_params)
    @leave.employee_id = current_account.profile.id
    @leave.start_date = params[:start_date]
    @leave.duration_seconds = @leave.duration_seconds.days
    if @leave.save
      redirect_to my_leaves_path, notice: "Leave successfully applied, please wait for admin to approve"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    @leave.update(action_by_id: current_account.id)
		if leave_params[:status] == "Approved"
		  @leave.approve
			redirect_to organization_leaves_path(current_organization), notice: 'Leaves request approved'
		elsif leave_params[:status]  == "Rejected"
		  @leave.reject
		  redirect_to organization_leaves_path(current_organization), notice: 'Leaves request rejected'
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
		params.require(:leave).permit(:start_date, :comment, :leave_type_id, :duration_seconds, :status)
	end
end
