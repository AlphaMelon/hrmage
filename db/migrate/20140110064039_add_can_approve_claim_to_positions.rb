class AddCanApproveClaimToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :can_approve_claim, :boolean
  end
end
