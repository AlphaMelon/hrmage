class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :organization_id
      t.integer :employee_id
      t.integer :clock_id
      t.datetime :clock_time

      t.timestamps
    end
  end
end
