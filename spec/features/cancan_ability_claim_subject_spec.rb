require 'spec_helper'

feature "[CanCan Ability Claim Subject]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Claim Subject without permission" do
    visit organization_claim_subjects_path(Organization.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Claim Subject with permission" do
    @acc_org.claim_subject = "Read Only"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Claim Subject without permission" do
    @acc_org.claim_subject = "Read Only"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    click_on "new_claim_subject"
    page.should have_content("Access denied")
  end
  
  scenario "Create Claim Subject with permission" do
    @acc_org.claim_subject = "Read and Create"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    click_on "new_claim_subject"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Claim Subject without permission" do
    @acc_org.claim_subject = "Read and Create"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    click_on "edit_claim_subject"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Claim Subject with permission" do
    @acc_org.claim_subject = "Read and Update"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    click_on "edit_claim_subject"
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Claim Subject without permission" do
    @acc_org.claim_subject = "Read and Create"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    click_on "delete_claim_subject"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Claim Subject with permission" do
    @acc_org.claim_subject = "Manage all"
    @acc_org.save
    visit organization_claim_subjects_path(Organization.first)
    click_on "edit_claim_subject"
    page.should_not have_content("Access denied")
  end  
end
