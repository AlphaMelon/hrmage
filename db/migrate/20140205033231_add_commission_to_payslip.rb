class AddCommissionToPayslip < ActiveRecord::Migration
  def change
    add_column :payslips, :commission_cents, :integer
  end
end
