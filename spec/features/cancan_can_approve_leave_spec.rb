require 'spec_helper'

feature "[CanCan Ability Leaves]" do
  background do
    create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end

  scenario "Approve Leave from other department" do
    visit organization_leaves_path(Organization.first)
    click_on "Approve"
    page.should have_content("Access denied")
  end
  
  scenario "Approve leave from own department" do
    ed = EmployeeDepartment.first
    ed.department_id = EmployeeDepartment.last.department_id
    ed.save
    
    visit organization_leaves_path(Organization.first)
    click_on "Approve"
    page.should have_content("Leaves request approved")
  end
  
  scenario "Approve Own Leave" do
    Leave.delete_all
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    visit organization_leaves_path(Organization.first)
    #all('#approve_leave')[0].click
    click_on("approve_leave")
    page.should have_content("Leaves request approved")
  end
  
  scenario "Approve Own Leave without authority" do
    employee = Employee.last
    employee.can_self_approve = false
    employee.save
    
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    visit organization_leaves_path(Organization.first)
    all('#approve_leave')[1].click
    page.should have_content("Access denied")
  end
end
