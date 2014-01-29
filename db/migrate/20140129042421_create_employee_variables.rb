class CreateEmployeeVariables < ActiveRecord::Migration
  def change
    create_table :employee_variables do |t|
      t.integer :employee_id
      t.integer :leave_type_id
      t.integer :available_leaves_seconds

      t.timestamps
    end
  end
end
