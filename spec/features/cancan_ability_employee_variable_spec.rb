require 'spec_helper'

feature "[CanCan Ability Employee]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Employee Variable without permission" do
    visit organization_employee_employee_variables_path(Organization.first, Employee.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Employee Variable with permission" do
    @acc_org.employee = "Read Only"
    @acc_org.save
    visit organization_employee_employee_variables_path(Organization.first, Employee.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Employee without permission" do
    @acc_org.employee = "Read and Create"
    @acc_org.save
    visit organization_employee_employee_variables_path(Organization.first, Employee.first)
    click_on "Edit"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Employee with permission" do
    @acc_org.employee = "Read and Update"
    @acc_org.save
    visit organization_employee_employee_variables_path(Organization.first, Employee.first)
    click_on "Edit"
    page.should_not have_content("Access denied")
  end

end
