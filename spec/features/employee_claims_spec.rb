require 'spec_helper'

feature "[Employee Claims]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Apply Claim" do
    visit root_path
    click_on "Apply Claim"
    select "Petrol", from: "Subject"
    fill_in "Date", with: "2014-01-27"
    fill_in "claim_amount_cents", with: "88.1"
    click_button "Apply Claim"
    page.should have_content("Claim successfully applied, please wait for approval")
  end
  
  scenario "Applying claim with blank field" do
    visit root_path
    click_on "Apply Claim"
    click_button "Apply Claim"
    page.should have_content("can't be blank")
  end

end
