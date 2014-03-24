class PositionSettingsController < ApplicationController
	before_action :set_organization
	before_action :set_position
	before_action :set_position_setting, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  load_and_authorize_resource
  
  def index
    @position_settings = @position.position_settings
  end
  
  def new
    @position_setting = @position.position_settings.new
  end 

  def create
    @position_setting = @position.position_settings.new(position_setting_params)
    @position_setting.max_leaves_seconds = position_setting_params[:max_leaves_seconds].to_i*working_hours*60*60 if !position_setting_params[:max_leaves_seconds].blank?
    if @position_setting.save
      redirect_to organization_position_position_settings_path(current_organization, @position), notice: "Position setting successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    @position_setting.update(position_setting_params)
    @position_setting.max_leaves_seconds = position_setting_params[:max_leaves_seconds].to_i*24*60*60 if !position_setting_params[:max_leaves_seconds].blank?
		if @position_setting.save
			redirect_to organization_position_position_settings_path(current_organization, @position), notice: 'Position setting successfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
		@position_setting.destroy
		redirect_to organization_position_position_settings_path(current_organization, @position), notice: 'Position setting successfully deleted'
	end

  private
	def set_position_setting
	  @position_setting = PositionSetting.find(params[:id])
	end
		
	def set_position
	  @position = Position.find(params[:position_id])
	end

	def set_organization
	  @organization = Organization.find(params[:organization_id])
	end

	def position_setting_params
		params.require(:position_setting).permit(:position_id, :leave_type_id, :leave_type, :max_leaves_seconds)
	end
end
