class RemoveCanApproveClaimsFromPositions < ActiveRecord::Migration
  def change
    remove_column :positions, :can_approve_claims, :boolean
  end
end
