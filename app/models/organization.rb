class Organization < ActiveRecord::Base
  has_many :departments
  has_many :account_organizations
  has_many :accounts, :through => :account_organizations
  has_many :employees
  has_many :leaves
  has_many :positions
  has_many :leave_types
  has_many :claims
  has_one :organization_setting
  has_many :organization_holidays
  
  validates :domain, uniqueness: true
  validates :domain, presence: true
  validates :name, presence: true
  validates :default_currency, presence: true
  
  before_save :setup_currency
  
  def setup_currency
    ::MoneyRails.configure do |config|
      config.default_currency = self.default_currency.to_sym if !self.default_currency.nil?
    end
  end
end
