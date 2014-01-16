class RemoveMaxLeavesFromPositions < ActiveRecord::Migration
  def change
    remove_column :positions, :max_leaves, :integer
  end
end
