class AddUseridToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :user_id, :integer
  end
end
