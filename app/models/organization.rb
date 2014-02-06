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
  has_many :payslips
  has_many :payslip_settings
  
  validates :domain, uniqueness: true
  validates :domain, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :default_currency, presence: true
  
  before_save :setup_currency
  
  accepts_nested_attributes_for :leave_types, allow_destroy: true
  def setup_currency
    ::MoneyRails.configure do |config|
      config.default_currency = self.default_currency.to_sym if !self.default_currency.nil?
    end
  end
end
