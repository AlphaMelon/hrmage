class Position < ActiveRecord::Base
  #max leave is just for prefilling, employee still get their individual amount of leaves
  has_many :employees
  has_many :position_settings
  belongs_to :organization
  validates :name, presence: true
  validates :monthly_max_claims_cents, presence: true
  
  monetize :monthly_max_claims_cents, as: "monthly_max_claims"
end
