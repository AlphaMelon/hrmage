class RemoveCommissionFromPayslip < ActiveRecord::Migration
  def change
    remove_column :payslips, :commission, :integer
  end
end
