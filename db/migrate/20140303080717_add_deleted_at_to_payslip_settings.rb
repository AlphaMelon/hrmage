class AddDeletedAtToPayslipSettings < ActiveRecord::Migration
  def change
    add_column :payslip_settings, :deleted_at, :datetime
    add_index :payslip_settings, :deleted_at
  end
end
