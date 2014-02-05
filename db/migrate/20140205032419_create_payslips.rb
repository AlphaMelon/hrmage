class CreatePayslips < ActiveRecord::Migration
  def change
    create_table :payslips do |t|
      t.integer :employee_id
      t.integer :organization_id
      t.datetime :date
      t.integer :commission

      t.timestamps
    end
  end
end
