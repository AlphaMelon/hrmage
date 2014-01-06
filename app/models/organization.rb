class Organization < ActiveRecord::Base
  has_many :departments
  has_many :account_organizations
  has_many :accounts, :through => :account_organizations
  has_many :employees
  has_many :leaves
  has_many :positions
  has_many :leave_types
  has_many :claims
  
  validates :domain, uniqueness: true
  validates :domain, presence: true
  validates :name, presence: true
end
