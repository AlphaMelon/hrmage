class Organization < ActiveRecord::Base
  has_many :departments
  has_many :account_organizations
  has_many :accounts, :through => :account_organizations
  
  has_many :employees
end
