require 'spec_helper'

feature "[Admin Position]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Position" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    page.should have_content("Executive")
  end 
  
  scenario "Add New Position" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Add New Position"
		fill_in 'Name', with: 'Manager'
		fill_in 'Max Leaves', with: 21
		fill_in 'Max Claims', with: 12000
		click_on "Create Position"
    page.should have_content("Position successfully created")
    page.should have_content("Manager")
  end

  scenario "Edit Position" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Edit"
		fill_in 'Name', with: 'Edited manager'
		click_on "Update Position"
    page.should have_content("Position successfully updated")
    page.should have_content("Edited manager")
  end

  scenario "submit position form without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Add New Position"
		click_on "Create Position"
    page.should have_content("can't be blank")
  end

end
