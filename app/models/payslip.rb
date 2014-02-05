class Payslip < ActiveRecord::Base

  has_many :payslip_calculations
  has_many :payslip_settings, :through => :payslip_calculations
  
end
