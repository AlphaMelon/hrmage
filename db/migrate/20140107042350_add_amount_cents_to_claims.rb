class AddAmountCentsToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :amount_cents, :integer
  end
end
