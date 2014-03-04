class RemoveClaimSubjectIdFromClaims < ActiveRecord::Migration
  def change
    remove_column :claims, :claim_subject_id, :integer
  end
end
