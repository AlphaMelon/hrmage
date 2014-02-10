class RemoveMaxclaimcentsFromPositions < ActiveRecord::Migration
  def change
    remove_column :positions, :max_claims_cents, :integer
  end
end
