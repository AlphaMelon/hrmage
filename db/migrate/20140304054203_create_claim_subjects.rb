class CreateClaimSubjects < ActiveRecord::Migration
  def change
    create_table :claim_subjects do |t|
      t.string :name

      t.timestamps
    end
  end
end
