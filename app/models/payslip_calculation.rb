class PayslipCalculation < ActiveRecord::Base

  belongs_to :payslip
  belongs_to :payslip_setting
end
