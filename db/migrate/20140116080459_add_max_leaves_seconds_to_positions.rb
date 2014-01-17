class AddMaxLeavesSecondsToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :max_leaves_seconds, :integer
  end
end
