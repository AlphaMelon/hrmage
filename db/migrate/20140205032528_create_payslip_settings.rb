class CreatePayslipSettings < ActiveRecord::Migration
  def change
    create_table :payslip_settings do |t|
      t.integer :organization_id
      t.string :name
      t.integer :value
      t.string :maths

      t.timestamps
    end
  end
end
