class CountryHolidaySetting < ActiveRecord::Base
  belongs_to :country_setting
  validates :name, :date, presence: true
end
