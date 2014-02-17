class CountrySetting < ActiveRecord::Base
  has_many :country_holiday_settings
end
