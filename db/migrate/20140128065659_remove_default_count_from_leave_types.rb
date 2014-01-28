class RemoveDefaultCountFromLeaveTypes < ActiveRecord::Migration
  def change
    remove_column :leave_types, :default_count, :integer
  end
end
