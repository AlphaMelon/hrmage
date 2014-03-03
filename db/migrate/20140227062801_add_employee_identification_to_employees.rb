class AddEmployeeIdentificationToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :employee_identification, :string
  end
end
