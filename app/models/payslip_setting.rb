class PayslipSetting < ActiveRecord::Base

  belongs_to :organization
  
  has_many :payslip_calculations
  has_many :payslips, :through => :payslip_calculations
  
  validates :name, presence: true
  validates :value, presence: true
  validates :maths, presence: true

  def positive?
    if self.maths == "Addition" || self.maths == "Multiplication" || self.maths == "Addition Percentage"
      return true
    elsif self.maths == "Substration" || self.maths == "Substraction Percentage" || self.maths == "Division"
      return false
    end
  end
end
