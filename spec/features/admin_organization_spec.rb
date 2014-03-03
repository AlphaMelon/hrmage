require 'spec_helper'

feature "[Admin Employee]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Edit Organization" do
    click_on "Admin"
    click_on "My Organization"
    click_on "edit_organization"
    select "United States Dollar - USD", from: "organization_default_currency", match: :first
    click_on "Update Organization"
    page.should have_content("Organization successfully updated")
    page.should have_content("usd")
  end
  
  scenario "Add Organization" do
    click_on "Add New Organization"
    fill_in 'Name', with: 'Hi lolZ'
    select "United States Dollar - USD", from: "organization_default_currency", match: :first
    click_on "Create Organization"
    page.should have_content("Organization successfully created")
    page.should have_content("Hi lolZ")
  end
end
