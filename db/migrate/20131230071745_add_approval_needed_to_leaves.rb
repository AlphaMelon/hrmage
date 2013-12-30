class AddApprovalNeededToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :approval_needed, :boolean
  end
end
