class AddDeletedAtToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :deleted_at, :datetime
    add_index :positions, :deleted_at
  end
end
