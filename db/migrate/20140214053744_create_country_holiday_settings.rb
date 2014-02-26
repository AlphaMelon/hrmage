class CreateCountryHolidaySettings < ActiveRecord::Migration
  def change
    create_table :country_holiday_settings do |t|
      t.integer :country_setting_id
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
