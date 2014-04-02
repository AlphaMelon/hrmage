class RemoveCanSelfApproveFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :can_self_approve, :boolean
  end
end
