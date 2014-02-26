class AddBasesalaryToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :base_salary_cents, :integer
  end
end
