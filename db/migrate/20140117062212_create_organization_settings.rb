class CreateOrganizationSettings < ActiveRecord::Migration
  def change
    create_table :organization_settings do |t|
      t.integer :organization_id
      t.integer :monday
      t.integer :tuesday
      t.integer :wednesday
      t.integer :thursday
      t.integer :friday
      t.integer :saturday
      t.integer :sunday
      t.integer :minimum_leave

      t.timestamps
    end
  end
end
