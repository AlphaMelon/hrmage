module PayslipMacros

  def create_payslip
    @payslip_attr = FactoryGirl.attributes_for(:payslip)
    @payslip = Payslip.create!(@payslip_attr)
    @payslip.organization = Organization.first
    @payslip.employee = Employee.first
    @payslip.save
    
    @payslip_calculation = PayslipCalculation.new
    @payslip_calculation.payslip = @payslip
    @payslip_calculation.payslip_setting = PayslipSetting.first
    @payslip_calculation.save
  end

  
end
