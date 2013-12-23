class AddAccountidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :account_id, :integer
  end
end
