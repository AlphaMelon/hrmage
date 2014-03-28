class AddDivideByDaysToLeaveTypes < ActiveRecord::Migration
  def change
    add_column :leave_types, :divide_by_days, :integer
    add_column :leave_types, :rules, :string
  end
end
