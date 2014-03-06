class AddModulesToAccountOrganizations < ActiveRecord::Migration
  def change
    add_column :account_organizations, :claim_subject, :string
    add_column :account_organizations, :department, :string
    add_column :account_organizations, :employee, :string
    add_column :account_organizations, :leave_type, :string
    add_column :account_organizations, :payslip, :string
    add_column :account_organizations, :payslip_setting, :string
    add_column :account_organizations, :position, :string
  end
end
