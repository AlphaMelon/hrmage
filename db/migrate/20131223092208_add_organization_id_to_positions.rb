class AddOrganizationIdToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :organization_id, :integer
  end
end
