class AddActionByIdToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :action_by_id, :integer
  end
end
