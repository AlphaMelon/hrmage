require 'spec_helper'

feature "[CanCan Ability Payslip Setting]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Payslip Setting without permission" do
    visit organization_payslip_settings_path(Organization.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Payslip Setting with permission" do
    @acc_org.payslip_setting = "Read Only"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Payslip Setting without permission" do
    @acc_org.payslip_setting = "Read Only"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    click_on "new_payslip_setting"
    page.should have_content("Access denied")
  end
  
  scenario "Create Payslip Setting with permission" do
    @acc_org.payslip_setting = "Read and Create"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    click_on "new_payslip_setting"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Payslip Setting without permission" do
    @acc_org.payslip_setting = "Read and Create"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    click_on "edit_payslip_setting"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Payslip Setting with permission" do
    @acc_org.payslip_setting = "Read and Update"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    click_on "edit_payslip_setting"
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Payslip Setting without permission" do
    @acc_org.payslip_setting = "Read and Create"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    click_on "delete_payslip_setting"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Payslip Setting with permission" do
    @acc_org.payslip_setting = "Manage all"
    @acc_org.save
    visit organization_payslip_settings_path(Organization.first)
    click_on "edit_payslip_setting"
    page.should_not have_content("Access denied")
  end  
end
