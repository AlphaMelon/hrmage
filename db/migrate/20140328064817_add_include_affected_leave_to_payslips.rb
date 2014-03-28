class AddIncludeAffectedLeaveToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :include_affected_leave, :boolean
    add_column :payslips, :leave_start_date, :date
    add_column :payslips, :leave_end_date, :date
  end
end
