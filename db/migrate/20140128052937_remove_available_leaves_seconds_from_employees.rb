class RemoveAvailableLeavesSecondsFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :available_leaves_seconds, :integer
  end
end
