class AddOrganizationIdToClaimSubjects < ActiveRecord::Migration
  def change
    add_column :claim_subjects, :organization_id, :integer
  end
end
