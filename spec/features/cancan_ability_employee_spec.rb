require 'spec_helper'

feature "[CanCan Ability Employee]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Employee without permission" do
    visit organization_employees_path(Organization.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Employee with permission" do
    @acc_org.employee = "Read Only"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Employee without permission" do
    @acc_org.employee = "Read Only"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    click_on "new_employee"
    page.should have_content("Access denied")
  end
  
  scenario "Create Employee with permission" do
    @acc_org.employee = "Read and Create"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    click_on "new_employee"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Employee without permission" do
    @acc_org.employee = "Read and Create"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    click_on "edit_employee", match: :first
    page.should have_content("Access denied")
  end
  
  scenario "Edit Employee with permission" do
    @acc_org.employee = "Read and Update"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    click_on "edit_employee", match: :first
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Employee without permission" do
    @acc_org.employee = "Read and Create"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    all('#delete_employee')[1].click
    page.should have_content("Access denied")
  end
  
  scenario "Delete Employee with permission" do
    @acc_org.employee = "Manage all"
    @acc_org.save
    visit organization_employees_path(Organization.first)
    all('#delete_employee')[1].click
    page.should_not have_content("Access denied")
  end  
end
