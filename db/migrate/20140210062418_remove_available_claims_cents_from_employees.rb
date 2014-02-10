class RemoveAvailableClaimsCentsFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :available_claims_cents, :integer
  end
end
