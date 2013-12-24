class CreateLeaveTypes < ActiveRecord::Migration
  def change
    create_table :leave_types do |t|
      t.string :name
      t.text :description
      t.string :affected_entity, array: true
      t.string :type
      t.integer :organization_id

      t.timestamps
    end
  end
end
