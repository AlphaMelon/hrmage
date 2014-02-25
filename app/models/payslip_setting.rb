class PayslipSetting < ActiveRecord::Base

  belongs_to :organization
  
  has_many :payslip_calculations, dependent: :destroy
  has_many :payslips, :through => :payslip_calculations
  
  validates :name, presence: true
  validates :value, presence: true
  validates :maths, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| controller.current_organization.id }

  def positive?
    if self.maths == "Addition" || self.maths == "Multiplication" || self.maths == "Addition Percentage"
      return true
    elsif self.maths == "Substration" || self.maths == "Substraction Percentage" || self.maths == "Division"
      return false
    end
  end
end
