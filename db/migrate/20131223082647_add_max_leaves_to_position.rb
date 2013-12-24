class AddMaxLeavesToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :max_leaves, :integer
  end
end
