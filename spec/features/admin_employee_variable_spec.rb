require 'spec_helper'

feature "[Admin employee variable]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "view employee variable" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Settings"
    page.should have_content("Annual")
  end
  
  scenario "edit employee variable" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Settings"
    click_on "Edit"
    fill_in "Available Leaves Remaining", with: "13"
    click_on "Update Employee's Setting"
    page.should have_content("Employee's settings successfully updated")
    page.should have_content("13")
  end
  
end
