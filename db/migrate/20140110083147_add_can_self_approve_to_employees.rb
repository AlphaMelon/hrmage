class AddCanSelfApproveToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :can_self_approve, :boolean
  end
end
