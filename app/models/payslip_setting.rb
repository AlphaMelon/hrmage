class PayslipSetting < ActiveRecord::Base

  has_many :payslip_calculations
  has_many :payslips, :through => :payslip_calculations
  
end
