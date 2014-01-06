class AddActionByIdToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :action_by_id, :integer
  end
end
