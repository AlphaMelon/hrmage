class CountryHolidaySetting < ActiveRecord::Base
  validates :name, :date, presence: true
end
