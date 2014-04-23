class AttendancesController < ApplicationController
	before_action :set_organization
	before_action :set_attendance, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  load_and_authorize_resource
  require 'csv'
  
  def index
    @attendances = current_organization.attendances.order(clock_time: :asc)
    @attendance = current_organization.attendances.new
    @employees = current_organization.employees.order(id: :asc)
    
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
    
  end
  
  def new
    @attendance = current_organization.attendances.new
  end 

  def create
    csv_text = File.read(params[:attendance_file].tempfile.to_path.to_s)
    csv = CSV.parse(csv_text, :headers => false)
    count = 0
    csv.each do |row|
      employee = current_organization.employees.where(employee_identification: row[03]).first
      if !employee.blank?
        date_str = "20#{row[01][4..5]}-#{row[01][2..3]}-#{row[01][0..1]} #{row[02][0..1]}:#{row[02][2..3]}"
        attendance = employee.attendances.where(clock_time: date_str.to_datetime).first_or_initialize
        attendance.organization_id = current_organization.id
        attendance.save
        count = count + 1 if attendance.save
      end
    end
    
    redirect_to organization_attendances_path(current_organization), notice: "#{count} Attendance successfully created"

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
