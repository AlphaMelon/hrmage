class AddDefaultCountToLeaveTypes < ActiveRecord::Migration
  def change
    add_column :leave_types, :default_count, :integer
  end
end
