require 'spec_helper'

feature "[CanCan Ability Payslip]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Payslip without permission" do
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Payslip with permission" do
    @acc_org.payslip = "Read Only"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Payslip without permission" do
    @acc_org.payslip = "Read Only"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    click_on "new_payslip"
    page.should have_content("Access denied")
  end
  
  scenario "Create Payslip with permission" do
    @acc_org.payslip = "Read and Create"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    click_on "new_payslip"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Payslip without permission" do
    @acc_org.payslip = "Read and Create"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    click_on "edit_payslip"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Payslip with permission" do
    @acc_org.payslip = "Read and Update"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    click_on "edit_payslip"
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Payslip without permission" do
    @acc_org.payslip = "Read and Create"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    click_on "delete_payslip"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Payslip with permission" do
    @acc_org.payslip = "Manage all"
    @acc_org.save
    visit organization_employee_payslips_path(Organization.first, Employee.first)
    click_on "edit_payslip"
    page.should_not have_content("Access denied")
  end  
end
