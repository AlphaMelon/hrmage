class Payslip < ActiveRecord::Base

  belongs_to :organization
  belongs_to :employee

  has_many :payslip_calculations, dependent: :destroy
  has_many :payslip_settings, :through => :payslip_calculations
  
  before_save :set_default_values
  validate :claim_start_and_end_date_cannot_nil_if_include_claim
  validate :leave_start_and_end_date_cannot_nil_if_include_affected_leave
  
  monetize :commission_cents, as: "commission"
  monetize :base_salary_cents, as: "base_salary"
  validates :date, presence: true
  validates :base_salary_cents, presence: true
  acts_as_paranoid
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
  
  def set_default_values
  end
  
  def claim_start_and_end_date_cannot_nil_if_include_claim
    if self.include_claim?
      if self.claim_start_date.blank? || self.claim_end_date.blank?
        errors.add("Claim Start and End Date", "cannot be empty")
      end
    end
  end

  def leave_start_and_end_date_cannot_nil_if_include_affected_leave
    if self.include_affected_leave?
      if self.leave_start_date.blank? || self.leave_end_date.blank?
        errors.add("Leave Start and End Date", "cannot be empty")
      end
    end
  end
  
  def calculate(payslip_setting, base_salary_cents)
    if payslip_setting.maths == "Addition"
      return payslip_setting.value*100
    elsif payslip_setting.maths == "Substration"
      return -payslip_setting.value*100
    elsif payslip_setting.maths == "Division"
      return base_salary_cents/payslip_setting.value
    elsif payslip_setting.maths == "Multiplication"
      return base_salary_cents*payslip_setting.value
    elsif payslip_setting.maths == "Addition Percentage"
      return base_salary_cents/100*payslip_setting.value
    elsif payslip_setting.maths == "Substraction Percentage"
      return -base_salary_cents/100*payslip_setting.value
    end  
  end
end

