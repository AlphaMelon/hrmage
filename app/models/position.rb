class Position < ActiveRecord::Base
  #max leave is just for prefilling, employee still get their individual amount of leaves
  has_many :employees
  belongs_to :organization
  validates :name, presence: true
  validates :max_leaves, presence: true
  validates :max_claims_cents, presence: true
  
  monetize :max_claims_cents, as: "max_claims"
end
