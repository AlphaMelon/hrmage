class AddAvailableClaimsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :available_claims_cents, :integer
  end
end
