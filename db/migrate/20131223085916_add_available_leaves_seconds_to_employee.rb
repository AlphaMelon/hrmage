class AddAvailableLeavesSecondsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :available_leaves, :integer
  end
end
