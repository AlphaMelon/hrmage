class Payslip < ActiveRecord::Base

  belongs_to :organization

  has_many :payslip_calculations
  has_many :payslip_settings, :through => :payslip_calculations
  
end
