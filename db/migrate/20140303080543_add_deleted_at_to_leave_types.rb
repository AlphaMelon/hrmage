class AddDeletedAtToLeaveTypes < ActiveRecord::Migration
  def change
    add_column :leave_types, :deleted_at, :datetime
    add_index :leave_types, :deleted_at
  end
end
