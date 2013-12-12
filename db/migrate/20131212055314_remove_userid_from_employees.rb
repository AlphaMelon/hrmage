class RemoveUseridFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :user_id, :integer
  end
end
