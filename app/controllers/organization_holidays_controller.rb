class OrganizationHolidaysController < ApplicationController
  before_action :set_organization_holiday, only: [:show, :edit, :update]
	before_action :set_organization_settings
	before_action :set_organization
	before_filter :authenticate_account!
	load_and_authorize_resource
	
  def index
    @organization_holidays = @organization.organization_holidays
  end
  
  def show
  end
  
  def new
    @organization_holiday = current_organization.organization_holidays.new
  end 

  def create
    @organization_holiday = current_organization.organization_holidays.new(organization_holiday_params)
    if @organization_holiday.save
      redirect_to organization_organization_setting_organization_holidays_path(current_organization, @organization_setting), notice: "Organization holiday successfully created"
    else
      render action: 'new', alert: "Please fill in the required field"
    end
  end
  
  def edit

  end
  
  def update
		if @organization_holiday.update(organization_holiday_params)
			redirect_to organization_organization_setting_organization_holidays_path(current_organization, @organization_setting), notice: 'Organization holiday successfully updated'
		else
			render action: 'edit'
		end
  end
  
	def destroy
		@organization_holiday.destroy
		redirect_to organization_organization_setting_organization_holidays_path(current_organization, @organization_setting), notice: 'Organization holidays successfully deleted'
	end
	
  private
  
	def set_organization_holiday
		@organization_holiday = OrganizationHoliday.find(params[:id])
	end
	
	def set_organization_settings
		@organization_setting = OrganizationSetting.find(params[:organization_setting_id])
	end

	def set_organization
		@organization = Organization.find(params[:organization_id])
	end

	def organization_holiday_params
		params.require(:organization_holiday).permit(:organization_id, :organization_holiday_id, :name, :date)
	end
end
