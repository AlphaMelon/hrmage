require 'spec_helper'

feature "[Employee Claims]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Apply Claim" do
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    fill_in "Subject", with: "Petrol"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
  end
  
  scenario "Applying claim with blank field" do
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    click_button "Apply Claim"
    page.should have_content("can't be blank")
  end

  scenario "Applying claim more than your available claims" do
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    fill_in "claim_amount", with: "9999999"
    click_button "Apply Claim"
    page.should have_content("is more than your available claims")
  end
  
  scenario "Applying claim with negative number" do
    visit root_path
    click_on "Claims", match: :first
    click_on "Apply Claim"
    fill_in "claim_amount", with: "-100"
    click_button "Apply Claim"
    page.should have_content("cannot be 0 or negative")
  end
  
  scenario "Claim remaining progress bar" do
    #0 out of 560000 claims remaining
    #approve claims of 77
    visit root_path
    click_on "Admin"
    click_on "organization_claims"
    click_on "approve_claim"
    page.should have_content("Claim application approved")
    
    #progress bar should be 77 out of 560000 leaves days
    #visit my_leaves_path
    click_on "Normal"
    click_on "my_claims", match: :first
    page.should have_content("77/5600.00")
  end

end
