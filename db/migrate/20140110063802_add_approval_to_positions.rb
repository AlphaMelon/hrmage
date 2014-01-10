class AddApprovalToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :can_approve_leave, :boolean
    add_column :positions, :can_approve_claims, :boolean
  end
end
