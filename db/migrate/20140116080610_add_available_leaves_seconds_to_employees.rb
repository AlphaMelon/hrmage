class AddAvailableLeavesSecondsToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :available_leaves_seconds, :integer
  end
end
