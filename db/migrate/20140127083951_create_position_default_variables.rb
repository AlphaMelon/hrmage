class CreatePositionDefaultVariables < ActiveRecord::Migration
  def change
    create_table :position_default_variables do |t|
      t.integer :position_id
      t.integer :leave_type_id
      t.integer :max_leaves_seconds

      t.timestamps
    end
  end
end
