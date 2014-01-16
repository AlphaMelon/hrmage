class RemoveAvailableLeavesFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :available_leaves, :integer
  end
end
