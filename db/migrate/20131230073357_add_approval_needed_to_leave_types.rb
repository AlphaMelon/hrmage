class AddApprovalNeededToLeaveTypes < ActiveRecord::Migration
  def change
    add_column :leave_types, :approval_needed, :boolean
  end
end
