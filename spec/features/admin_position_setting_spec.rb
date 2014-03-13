require 'spec_helper'

feature "[Admin Position Setting]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Position setting" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Settings"
    page.should have_content("settings")
  end 
  
  scenario "Add New Position setting" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Settings"
    click_on "new_position_setting"
		fill_in 'position_setting_max_leaves_seconds', with: 20
		click_on "Create Position setting"
    page.should have_content("Position setting successfully created")
    page.should have_content("20")
  end

  scenario "Edit Position setting" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Settings"
    click_on "edit_position_setting"
		fill_in 'position_setting_max_leaves_seconds', with: 30
		click_on "Update Position setting"
    page.should have_content("Position setting successfully updated")
    page.should have_content("30")
  end

  scenario "delete Position setting" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Settings"
    page.should have_content("21")
    click_on "delete_position_setting"
    page.should have_content("Position setting successfully deleted")
    page.should_not have_content("21")
  end

  scenario "submit position setting form without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Position"
    click_on "Settings"
    click_on "new_position_setting"
    fill_in "position_setting_max_leaves_seconds", with: ""
		click_on "Create Position setting"
    page.should have_content("can't be blank")
  end

end
