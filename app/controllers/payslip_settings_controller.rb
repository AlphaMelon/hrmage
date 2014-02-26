class PayslipSettingsController < ApplicationController
  before_action :set_organization
  before_action :set_payslip_setting, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_account!

  load_and_authorize_resource

  def index
    @payslip_settings = @organization.payslip_settings.order(id: :asc)
  end

  def new
    @payslip_setting = @organization.payslip_settings.new
  end

  def create
    @payslip_setting = @organization.payslip_settings.new(payslip_setting_params)
    @payslip_setting.organization_id = current_organization.id
    if @payslip_setting.save
      redirect_to organization_payslip_settings_path(current_organization), notice: "Payslip Setting successfully created"
    else
      render action: 'new'
    end
  end

  def edit
    
  end

  def update
    if @payslip_setting.update(payslip_setting_params)
      redirect_to organization_payslip_settings_path(current_organization), notice: "Payslip Setting successfully update"
    else
      render action: 'edit'
    end
  end
  
	def destroy
	  if @payslip_setting.payslip_calculations.blank?
		  @payslip_setting.destroy
		  redirect_to organization_payslip_settings_path(current_organization), notice: 'Payslip setting successfully deleted'
		else
		  redirect_to organization_payslip_settings_path(current_organization), alert: 'You cannot delete this setting because it is being used for payslips.'
		end
	end
	
  private
  
  def set_payslip_setting
    @payslip_setting = PayslipSetting.find(params[:id])
  end
  
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def payslip_setting_params
    params.require(:payslip_setting).permit(:organization_id, :name, :value, :maths)
  end
end
