class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :subject
      t.datetime :date
      t.decimal :amount
      t.text :comment
      t.string :image
      t.string :status
      t.integer :organization_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
