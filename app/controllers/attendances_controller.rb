class AttendancesController < ApplicationController
	before_action :set_organization
	before_action :set_attendance, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  load_and_authorize_resource
  require 'csv'
  
  def index
    @attendances = current_organization.attendances.order(clock_time: :asc)
    @attendance = current_organization.attendances.new
    
  end
  
  def new
    @attendance = current_organization.attendances.new
  end 

  def create
    csv_text = File.read(params[:attendance_file].tempfile.to_path.to_s)
    csv = CSV.parse(csv_text, :headers => false)
    csv.each do |row|
      raise row.inspect
    end
    
    @attendance = current_organization.attendances.new(attendance_params)
    if @attendance.save
      redirect_to organization_attendances_path(current_organization), notice: "Attendance successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @attendance.update(attendance_params)
			redirect_to organization_attendances_path(current_organization), notice: 'Attendance successfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
		@attendance.destroy
		redirect_to organization_attendances_path, notice: 'Attendance successfully deleted'
	end

  private
	
	def set_attendance
	  @attendance = Attendance.find(params[:id])
	end

	def set_organization
	  @organization = Organization.find(params[:organization_id])
	end

	def attendance_params
		params.require(:attendance).permit(:organization_id, :employee_id, 
		:clock_time)
	end
end
