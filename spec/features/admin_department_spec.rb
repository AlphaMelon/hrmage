require 'spec_helper'

feature "[Admin Department]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Department" do
    visit root_path
    click_on "View Departments"
    click_on "Show"
    page.should have_content("Account")
  end 
  
  scenario "Add New Department" do
    visit root_path
    click_on "Add New Department"
		fill_in 'Name', with: 'Sales'
		click_on "Create Department"
    page.should have_content("Department successfully created")
    page.should have_content("Sales")
  end

  scenario "Edit Department" do
    visit root_path
    click_on "View Department"
    click_on "Edit"
		fill_in 'Last name', with: 'Edited Sales'
		click_on "Update Department"
    page.should have_content("Department successfully updated")
    page.should have_content("Edited Sales")
  end


end
