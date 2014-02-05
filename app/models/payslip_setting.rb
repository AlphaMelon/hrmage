class PayslipSetting < ActiveRecord::Base

  belongs_to :organization
  
  has_many :payslip_calculations
  has_many :payslips, :through => :payslip_calculations
  
end
