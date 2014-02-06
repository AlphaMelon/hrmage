class PayslipSettingsController < ApplicationController
  before_action :set_organization
  before_filter :authenticate_account!

  load_and_authorize_resource

  def index
    @payslip_settings = @organization.payslip_settings
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

  private
  
  def set_claim
    @payslip_setting = PayslipSetting.find(params[:id])
  end
  
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def payslip_setting_params
    params.require(:payslip_setting).permit(:organization_id, :name, :value, :maths)
  end
end