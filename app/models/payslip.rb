class Payslip < ActiveRecord::Base

  belongs_to :employee

  has_many :payslip_calculations
  has_many :payslip_settings, :through => :payslip_calculations

  monetize :commission_cents, as: "commission"
  validates :date, presence: true
  
end
