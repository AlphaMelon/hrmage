module PayslipMacros

  def create_payslip
    @payslip_attr = FactoryGirl.attributes_for(:payslip)
    @payslip = Payslip.create!(@payslip_attr)
    @payslip.organization = Organization.first
    @payslip.employee = Employee.first
    @payslip.save
        
  end

  
end
