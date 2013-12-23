class AddOrganizationidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :organization_id, :integer
  end
end
