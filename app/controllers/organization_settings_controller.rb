class OrganizationSettingsController < ApplicationController
	before_action :set_organization_settings, only: [:show, :edit, :update]
	before_action :set_organization
	before_filter :authenticate_account!
	load_and_authorize_resource
	
  def index
    @organization_setting = @organization.organization_setting
  end
  
  def show
  end
  
  def new
    @organization_setting = current_organization.build_organization_setting
  end 

  def create
    @organization_setting = current_organization.build_organization_setting(organization_setting_params)
    if @organization_setting.save
      redirect_to organization_organization_settings_path(current_organization), notice: "Organization setting successfully created"
    else
      render action: 'new', alert: "Please fill in the required field"
    end
  end
  
  def edit

  end
  
  def update
		if @organization_setting.update(organization_setting_params)
			redirect_to organization_organization_settings_path(current_organization), notice: 'Organization settings successfully updated'
		else
			render action: 'edit'
		end
  end
  
	def destroy
		@organization_setting.destroy
		redirect_to organization_organization_settings_path(current_organization), notice: 'Organization settings successfully deleted'
	end
	
  private
  
	def set_organization_settings
		@organization_setting = OrganizationSetting.find(params[:id])
	end

	def set_organization
		@organization = Organization.find(params[:organization_id])
	end

	def organization_setting_params
		params.require(:organization_setting).permit(:organization_id, :minimum_leave, 
		:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
	end
end
