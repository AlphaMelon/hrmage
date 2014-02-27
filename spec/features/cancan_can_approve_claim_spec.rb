require 'spec_helper'

feature "[CanCan Ability Claims]" do
  background do
    create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end

  scenario "Approve Claim from another department" do
    visit organization_claims_path(Organization.first)
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
  
  scenario "Approve Own claim" do
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    fill_in "Subject", with: "Petrol"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
    
    visit organization_claims_path(Organization.first)
    all('#approve_claim')[1].click
    page.should have_content("Claim application approved")
  end
  
  scenario "Approve Own Claim without authority" do
    employee = Employee.last
    employee.can_self_approve = false
    employee.save
    
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    fill_in "Subject", with: "Petrol"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
    
    visit organization_claims_path(Organization.first)
    all('#approve_claim')[1].click
    page.should have_content("Access denied")
  end
end
