class AddMaxClaimsToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :max_claims_cents, :integer
  end
end
