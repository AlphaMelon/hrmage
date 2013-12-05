class RemoveDepartmentidFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :department_id, :integer
  end
end
