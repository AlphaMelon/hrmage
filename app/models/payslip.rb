class Payslip < ActiveRecord::Base

  belongs_to :organization
  belongs_to :employee

  has_many :payslip_calculations
  has_many :payslip_settings, :through => :payslip_calculations
  
  monetize :commission_cents, as: "commission"
  monetize :base_salary_cents, as: "base_salary"
  validates :date, presence: true
  validates :base_salary_cents, presence: true
end
