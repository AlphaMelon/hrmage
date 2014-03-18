class AddCanSelfApproveToAccountOrganizations < ActiveRecord::Migration
  def change
    add_column :account_organizations, :can_self_approve, :boolean
  end
end
