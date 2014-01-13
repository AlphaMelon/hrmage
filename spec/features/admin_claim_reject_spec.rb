require 'spec_helper'

feature "[Admin approve claim]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Approve Claim" do
    visit root_path
    click_on "Admin"
    click_on "organization_claims"
    click_on "reject_claim"
    page.should have_content("Claim application rejected")
  end

end
