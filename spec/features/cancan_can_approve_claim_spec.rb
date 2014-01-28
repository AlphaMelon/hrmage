require 'spec_helper'

feature "[CanCan Ability Claims]" do
  background do
    create_employee_cancan(false, true)
    admin_login("testing@example.dev", "spree123")
  end

  scenario "Approve Claim" do
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/claims"
    click_on "Approve"
    page.should have_content("Claim application approved")
  end
  
  scenario "Read Leaves" do
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/leaves"
    page.should have_content("Access denied.")
  end
  
  scenario "Approve Own claim" do
    visit root_path
    click_on "Claims"
    click_on "Apply Claim"
    fill_in "Subject", with: "Petrol"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
    
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/claims"
    all('#approve_claim')[1].click
    page.should have_content("Claim application approved")
  end
  
  scenario "Approve Own Claim without authority" do
    employee = Employee.last
    employee.can_self_approve = false
    employee.save
    
    visit root_path
    click_on "Claims"
    click_on "Apply Claim"
    fill_in "Subject", with: "Petrol"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
    
    visit "http://staff.alphamelon.dev/organizations/#{Organization.first.id}/claims"
    all('#approve_claim')[1].click
    page.should have_content("Access denied")
  end
end
