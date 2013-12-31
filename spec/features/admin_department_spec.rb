require 'spec_helper'

feature "[Admin Department]" do
  background do
    admin_login("spree@example.com", "spree123")
    #click_on "Alphamelon"
  end
  
  scenario "Show Department" do
    visit organizations_path
    click_on "Show"
    click_on "Department list"
    click_on "Show"
    page.should have_content("Account")
  end 
  
  scenario "Add New Department" do
    visit organizations_path
    click_on "Show"
    click_on "Department list"
    click_on "New Department"
		fill_in 'Name', with: 'Sales'
		click_on "Create Department"
    page.should have_content("Department successfully created")
    page.should have_content("Sales")
  end

  scenario "Edit Department" do
    visit organizations_path
    click_on "Show"
    click_on "Department list"
    click_on "Edit"
		fill_in 'Name', with: 'Edited Sales'
		click_on "Update Department"
    page.should have_content("Department successfully updated")
    page.should have_content("Edited Sales")
  end


end
