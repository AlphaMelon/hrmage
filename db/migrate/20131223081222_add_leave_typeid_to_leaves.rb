class AddLeaveTypeidToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :leave_type_id, :integer
    add_column :leaves, :duration_seconds, :integer
  end
end
