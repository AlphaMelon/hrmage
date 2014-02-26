class CreateCountrySettings < ActiveRecord::Migration
  def change
    create_table :country_settings do |t|
      t.string :country

      t.timestamps
    end
  end
end
