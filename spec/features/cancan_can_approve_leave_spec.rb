require 'spec_helper'

feature "[CanCan Ability Leaves]" do
  background do
    create_employee_cancan(true, false)
    admin_login("testing@example.dev", "spree123")
  end

  scenario "Approve Leave" do
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/leaves"
    click_on "Approve"
    page.should have_content("Leaves request approved")
  end
  
  scenario "Read Claims" do
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/claims"
    page.should have_content("Access denied.")
  end
  
  scenario "Approve Own Leave" do
    visit root_path
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/leaves"
    all('#approve_leave')[1].click
    page.should have_content("Leaves request approved")
  end
  
  scenario "Approve Own Leave without authority" do
    employee = Employee.last
    employee.can_self_approve = false
    employee.save
    
    visit root_path
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/leaves"
    all('#approve_leave')[1].click
    page.should have_content("Access denied")
  end
end
