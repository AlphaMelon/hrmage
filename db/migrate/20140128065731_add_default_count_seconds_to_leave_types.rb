class AddDefaultCountSecondsToLeaveTypes < ActiveRecord::Migration
  def change
    add_column :leave_types, :default_count_seconds, :integer
  end
end
