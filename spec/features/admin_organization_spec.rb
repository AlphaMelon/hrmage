require 'spec_helper'

feature "[Admin Organization]" do
  background do
    #create organization first
    Capybara.app_host = "http://becon.dev:#{Capybara.server_port}/?beta=1"
    sign_up_account("second@example.dev", "spree123")
    visit root_path
    click_on "Add New Organization"
    fill_in 'Name', with: 'Becon'
    fill_in 'Domain', with: "becon.dev"
    click_on "Create Organization"
    page.should have_content("Organization successfully created")
    page.should have_content("Becon")
  end
  
  scenario "Edit Organization" do
    visit "http://becon.dev:#{Capybara.server_port}/organizations"
    click_on "Edit"
    fill_in 'Name', with: 'Becon edited'
    click_on "Update Organization"
    page.should have_content("Organization successfully updated")
    page.should have_content("Becon edited")
  end
end
