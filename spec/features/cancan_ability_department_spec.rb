require 'spec_helper'

feature "[CanCan Ability Department]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Department without permission" do
    visit organization_departments_path(Organization.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Department with permission" do
    @acc_org.department = "Read Only"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Department without permission" do
    @acc_org.department = "Read Only"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    click_on "new_department"
    page.should have_content("Access denied")
  end
  
  scenario "Create Department with permission" do
    @acc_org.department = "Read and Create"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    click_on "new_department"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Department without permission" do
    @acc_org.department = "Read and Create"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    click_on "edit_department"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Department with permission" do
    @acc_org.department = "Read and Update"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    click_on "edit_department"
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Department without permission" do
    @acc_org.department = "Read and Create"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    click_on "delete_department"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Department with permission" do
    @acc_org.department = "Manage all"
    @acc_org.save
    visit organization_departments_path(Organization.first)
    click_on "edit_department"
    page.should_not have_content("Access denied")
  end  
end
