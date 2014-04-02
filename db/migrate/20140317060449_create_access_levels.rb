class CreateAccessLevels < ActiveRecord::Migration
  def change
    create_table :access_levels do |t|
      t.integer :account_organization_id
      t.integer :department_id
      t.string :access_level
      t.string :class_name

      t.timestamps
    end
  end
end
