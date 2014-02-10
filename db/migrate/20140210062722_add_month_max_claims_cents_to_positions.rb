class AddMonthMaxClaimsCentsToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :monthly_max_claims_cents, :integer
  end
end
