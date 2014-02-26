class Position < ActiveRecord::Base
  #max leave is just for prefilling, employee still get their individual amount of leaves
  has_many :employees
  has_many :position_settings, dependent: :destroy
  belongs_to :organization
  validates :name, presence: true
  validates :monthly_max_claims_cents, presence: true
  
  monetize :monthly_max_claims_cents, as: "monthly_max_claims"
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| controller.current_organization.id }

end
