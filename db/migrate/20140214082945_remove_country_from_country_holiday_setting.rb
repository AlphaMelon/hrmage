class RemoveCountryFromCountryHolidaySetting < ActiveRecord::Migration
  def change
    remove_column :country_holiday_settings, :country, :string
  end
end
