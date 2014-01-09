class AddDefaultCurrencyToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :default_currency, :string
  end
end
