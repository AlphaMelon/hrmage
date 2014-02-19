class CountrySetting < ActiveRecord::Base
  has_many :country_holiday_settings, dependent: :destroy
  validates :country, presence: true
end
