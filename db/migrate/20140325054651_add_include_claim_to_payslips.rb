class AddIncludeClaimToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :include_claim, :boolean
    add_column :payslips, :claim_start_date, :date
    add_column :payslips, :claim_end_date, :date
    add_column :payslips, :note, :string
  end
end
