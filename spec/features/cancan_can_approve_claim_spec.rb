require 'spec_helper'

feature "[CanCan Ability Claims]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    @access_level = @acc_org.access_levels.first
    admin_login("testing@example.dev", "spree123")
  end

  scenario "Approve Claim without authority" do
    @access_level.class_name = "Leave"
    @access_level.save
    visit organization_claims_path(Organization.first)
    click_on "Approve"
    page.should have_content("Access denied")
  end
  
  scenario "Approve claim with authority" do
    @access_level.class_name = "Claim"
    @access_level.access_level = "Read and Update"
    @access_level.department_id = Department.last.id
    @access_level.save
    
    visit organization_claims_path(Organization.first)
    click_on "Approve"
    page.should have_content("Claim application approved")
  end
  
  scenario "Approve Own claim" do
    @acc_org.can_self_approve = true
    @acc_org.save
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    select "Petrol", from: "Subject" 
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")

    visit organization_claims_path(Organization.first)
    all('#approve_claim')[0].click
    page.should have_content("Claim application approved")
  end
  
  scenario "Approve Own Claim without authority" do
    @acc_org.can_self_approve = false
    @acc_org.save
    
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    select "Petrol", from: "Subject"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
    
    visit organization_claims_path(Organization.first)
    all('#approve_claim')[0].click
    page.should have_content("Access denied")
  end
end
