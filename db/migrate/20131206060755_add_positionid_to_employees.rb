class AddPositionidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :position_id, :integer
  end
end
