class CreateEmployees < ActiveRecord::Migration
  def change
    execute "create extension hstore"
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_contact
      t.string :address
      t.string :photo
      t.hstore :properties

      t.timestamps
    end
  end
end
