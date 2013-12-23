class Organization < ActiveRecord::Base
  has_many :departments
  has_many :account_organizations
  has_many :accounts, :through => :account_organizations
  has_many :employees
  has_many :leaves
  
  validates :domain, uniqueness: true
  validates :domain, presence: true
  validates :name, presence: true
end
