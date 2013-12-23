class CreateAccountOrganizations < ActiveRecord::Migration
  def change
    create_table :account_organizations do |t|
      t.integer :account_id
      t.integer :organization_id
      t.string :role

      t.timestamps
    end
  end
end
