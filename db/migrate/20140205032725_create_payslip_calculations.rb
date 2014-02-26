class CreatePayslipCalculations < ActiveRecord::Migration
  def change
    create_table :payslip_calculations do |t|
      t.integer :payslip_id
      t.integer :payslip_setting_id

      t.timestamps
    end
  end
end
