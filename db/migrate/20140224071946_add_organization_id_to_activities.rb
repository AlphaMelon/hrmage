class AddOrganizationIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :organization_id, :integer
  end
end
