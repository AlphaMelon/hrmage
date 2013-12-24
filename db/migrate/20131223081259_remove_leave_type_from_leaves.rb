class RemoveLeaveTypeFromLeaves < ActiveRecord::Migration
  def change
    remove_column :leaves, :leave_type
    remove_column :leaves, :end_date
  end
end
