class AddCountryToCountryHolidaySettings < ActiveRecord::Migration
  def change
    add_column :country_holiday_settings, :country, :string
  end
end
