class AddDeletedAtToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :deleted_at, :datetime
    add_index :payslips, :deleted_at
  end
end
