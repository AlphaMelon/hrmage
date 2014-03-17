class AccountOrganization < ActiveRecord::Base
  belongs_to :account
  belongs_to :organization
  has_many :access_levels
  
  validates :account_id, presence: { message: "is not found in database, please try another email"}
  validates :organization_id, presence: true
  validates :role, presence: true
  
end
