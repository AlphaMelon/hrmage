class AddClaimSubjectIdToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :claim_subject_id, :integer
  end
end
