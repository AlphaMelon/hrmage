class LeavesController < ApplicationController
	before_action :set_organization
	before_action :set_leave, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
	
	load_and_authorize_resource
  
  def index
    
    @search = @organization.leaves.search(params[:q])
    if params[:q].nil?
      @leaves = @organization.leaves.order(id: :desc).page(params[:leave_page]).per(5)
    else
      @leaves = @search.result.order(id: :desc).page(params[:leave_page]).per(5)
    end
    
    @pending_leaves = @organization.leaves.where(status: "Pending")
    @verification_needed_leaves = @organization.leaves.where(status: "Verification Needed")
    @leave_types = @organization.leave_types
  
    @month = !params[:date].blank? ? params[:date][:month].to_i : DateTime.now.month
    @year = !params[:date].blank? ? params[:date][:year].to_i : DateTime.now.year
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
    
    if !current_organization.organization_setting.nil?
      @workday = [false,false,false,false,false,false,false,false]
      @workday[1] = true if !current_organization.organization_setting.monday.blank? && current_organization.organization_setting.monday != 0
      @workday[2] = true if !current_organization.organization_setting.tuesday.blank? && current_organization.organization_setting.tuesday != 0
      @workday[3] = true if !current_organization.organization_setting.wednesday.blank? && current_organization.organization_setting.wednesday != 0
      @workday[4] = true if !current_organization.organization_setting.thursday.blank? && current_organization.organization_setting.thursday != 0
      @workday[5] = true if !current_organization.organization_setting.friday.blank? && current_organization.organization_setting.friday != 0
      @workday[6] = true if !current_organization.organization_setting.saturday.blank? && current_organization.organization_setting.saturday != 0
      @workday[7] = true if !current_organization.organization_setting.sunday.blank? && current_organization.organization_setting.sunday != 0
    end
    
    
  end
  
  def new
    @leave = current_organization.leaves.new
    @leave_types = current_organization.leave_types.all
  end 

  def create
    @leave = current_organization.leaves.new(leave_params)
    @leave.employee_id = current_employee.id if @leave.employee_id.nil?
    if params[:hour_or_day] == "Hours"
      @leave.duration_seconds = @leave.duration_seconds*60*60 if !@leave.duration_seconds.nil?
    else
      @leave.duration_seconds = @leave.duration_seconds*working_hours*60*60 if !@leave.duration_seconds.nil?
    end
    @leave.status = "Verification Needed" if !@leave.leave_type.approval_needed
    if @leave.save
      @leave.employee.departments.each do |department|
        department.employee_departments.where(leader: true).each do |employee_department|
          UserMailer.apply_leave(employee_department.employee.account, @leave, employee_department.employee).deliver if !employee_department.employee.account.nil?
        end
      end
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
		  UserMailer.leave_approval(@leave.employee.account, @leave, @leave.employee).deliver if !@leave.employee.account.nil?
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
		params.require(:leave).permit(:start_date, :comment, :leave_type_id, 
		:duration_seconds, :status, :employee_id)
	end
end
