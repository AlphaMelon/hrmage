class Payslip < ActiveRecord::Base

  belongs_to :organization
  belongs_to :employee

  has_many :payslip_calculations
  has_many :payslip_settings, :through => :payslip_calculations
  
  monetize :commission_cents, as: "commission"
  monetize :base_salary_cents, as: "base_salary"
  validates :date, presence: true
  validates :base_salary_cents, presence: true
  
  def calculate(payslip_setting)
    if payslip_setting.maths == "Addition"
      return payslip_setting.value*100
    elsif payslip_setting.maths == "Substration"
      return -payslip_setting.value*100
    elsif payslip_setting.maths == "Division"
      return self.base_salary_cents/payslip_setting.value
    elsif payslip_setting.maths == "Multiplication"
      return self.base_salary_cents*payslip_setting.value
    elsif payslip_setting.maths == "Addition Percentage"
      return self.base_salary_cents/100*payslip_setting.value
    elsif payslip_setting.maths == "Substraction Percentage"
      return -self.base_salary_cents/100*payslip_setting.value
    end
    
  end

end

