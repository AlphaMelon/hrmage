require 'spec_helper'

feature "[CanCan Ability Employee Departments]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Create Employee Departments without permission" do
    @acc_org.employee = "Read Only"
    @acc_org.save
    visit new_organization_employee_employee_department_path(Organization.first, Employee.first)
    page.should have_content("Access denied")
  end
  
  scenario "Create Employee Departments with permission" do
    @acc_org.employee = "Read and Create"
    @acc_org.save
    visit new_organization_employee_employee_department_path(Organization.first, Employee.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Employee Departments without permission" do
    @acc_org.employee = "Read and Update"
    @acc_org.save
    visit edit_organization_employee_path(Organization.first, Employee.first)
    click_on "delete_department_link"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Employee Departments with permission" do
    @acc_org.employee = "Manage all"
    @acc_org.save
    visit edit_organization_employee_path(Organization.first, Employee.first)
    click_on "delete_department_link"
    page.should_not have_content("Access denied")
  end  
end
