require 'spec_helper'

feature "[Admin Organization]" do
  background do
    sign_up_account("second@example.dev", "spree123")
    
    #create organization first
    visit root_path
    click_on "Create New Organization"
    fill_in 'Name', with: 'Becon'
    fill_in 'Domain', with: "becon.com"
    click_on "Create Organization"
    page.should have_content("Organization successfully created")
    page.should have_content("Becon")
  end
  
  scenario "Edit Organization" do
    visit root_path
    click_on "Manage Organization"
    click_on "Edit"
    fill_in 'Name', with: 'Becon EDITED'
    click_on "Update Organization"
    page.should have_content("Organization successfully updated")
    page.should have_content("Becon EDITED")
  end
end
