class RemoveApprovalNeededFromLeaves < ActiveRecord::Migration
  def change
    remove_column :leaves, :approval_needed, :boolean
  end
end
