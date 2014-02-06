class AddBaseSalaryCentsToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :base_salary_cents, :integer
  end
end
