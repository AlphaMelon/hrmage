class AddDeletedAtToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :deleted_at, :datetime
    add_index :claims, :deleted_at
  end
end
