class AddOrganizationidToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :organization_id, :integer
  end
end
