class CreateEmployeeDepartments < ActiveRecord::Migration
  def change
    create_table :employee_departments do |t|
      t.integer :employee_id
      t.integer :department_id
      t.boolean :leader, default: false
      t.hstore :properties

      t.timestamps
    end
  end
end
