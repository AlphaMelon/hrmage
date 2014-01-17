class CreateOrganizationHolidays < ActiveRecord::Migration
  def change
    create_table :organization_holidays do |t|
      t.string :name
      t.date :date
      t.integer :organization_setting_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
