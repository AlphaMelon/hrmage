class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :comment
      t.string :leave_type
      t.string :status
      t.hstore :properties
      t.integer :employee_id

      t.timestamps
    end
  end
end
