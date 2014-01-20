require 'spec_helper'

feature "[Admin Organization Setting]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show setting" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    page.should have_content("Monday")
  end
  
  scenario "Edit setting" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Edit"
		fill_in 'Monday', with: 24
		click_on "Update Organization setting"
		page.should have_content("Organization settings successfully updated")
    page.should have_content("24")
  end
  
  scenario "delete and add New Position" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Delete"
    page.should have_content("Organization settings successfully deleted")
    
    click_on "Create Settings"
		fill_in 'Monday', with: 18
		fill_in 'Tuesday', with: 17
		click_on "Create Organization setting"
    page.should have_content("Organization setting successfully created")
    page.should have_content("18")
    page.should have_content("17")
  end




end