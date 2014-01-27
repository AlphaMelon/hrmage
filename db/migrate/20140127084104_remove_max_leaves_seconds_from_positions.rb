class RemoveMaxLeavesSecondsFromPositions < ActiveRecord::Migration
  def change
    remove_column :positions, :max_leaves_seconds, :integer
  end
end
