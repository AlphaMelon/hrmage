class AddColourToLeaveTypes < ActiveRecord::Migration
  def change
    add_column :leave_types, :colour, :string
  end
end
