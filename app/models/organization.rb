class Organization < ActiveRecord::Base
  has_many :departments, dependent: :destroy
  has_many :account_organizations, dependent: :destroy
  has_many :accounts, :through => :account_organizations
  has_many :employees, dependent: :destroy
  has_many :leaves, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :leave_types, dependent: :destroy
  has_many :claims, dependent: :destroy
  has_one :organization_setting, dependent: :destroy
  has_many :organization_holidays, dependent: :destroy
  has_many :payslips, dependent: :destroy
  has_many :payslip_settings, dependent: :destroy
  
  validates :domain, uniqueness: true
  validates :domain, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :default_currency, presence: true
  validates :country, presence: true
  
  before_save :setup_currency
  before_validation :remove_special_character_from_name_and_automatically_generate_domain
  
  accepts_nested_attributes_for :leave_types, allow_destroy: true
  def setup_currency
    ::MoneyRails.configure do |config|
      config.default_currency = self.default_currency.to_sym if !self.default_currency.nil?
    end
  end
  
  def remove_special_character_from_name_and_automatically_generate_domain
    if !self.name.blank?
      domain_string = self.name.gsub(/[^0-9A-Za-z]/, '') 
      if Rails.env == "development" || Rails.env == "test"
        self.domain = (domain_string.downcase.delete(" ") + ".hrmage.dev")
      elsif Rails.env == "production"
        self.domain = (domain_string.downcase.delete(" ") + ".officemage.com")
      end
    end
  end
end
