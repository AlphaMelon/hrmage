module PayslipSettingMacros

  def create_payslip_setting
    @payslip_setting_attr = FactoryGirl.attributes_for(:payslip_setting)
    @payslip_setting = PayslipSetting.create!(@payslip_setting_attr)
    @payslip_setting.organization = Organization.first
    @payslip_setting.save
        
  end

  
end
