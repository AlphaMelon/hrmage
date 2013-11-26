require 'spec_helper'

feature "[Admin Employee]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Employee" do
    visit root_path
    click_on "Admin Panel"
    click_on "Manage Employees"
    click_on "Show"
    page.should have_content("spree@example.com")
  end 
  
  scenario "Add New Employee" do
    visit root_path
    click_on "Admin Panel"
    click_on "Manage Employees"
    click_on "New Employee"
		fill_in 'Last name', with: 'Lee'
		fill_in 'First name', with: 'Alan'
		fill_in 'Mobile contact', with: '016-3134415'
		fill_in 'Address', with: 'klang'
		fill_in 'Email', with: 'alanlee@example.dev'
		fill_in 'Password', with: 'spree123'
		select "Employee", from: "Role"
		click_on "Create Employee"
    page.should have_content("Employee successfully created")
    page.should have_content("Lee")
  end

  scenario "Edit Employee" do
    visit root_path
    click_on "Admin Panel"
    click_on "Manage Employees"
    click_on "Edit"
		fill_in 'Last name', with: 'Edited Wong'
		click_on "Update Employee"
    page.should have_content("Employee successfully updated")
    page.should have_content("Edited Wong")
  end

  scenario "Edit login info" do
    visit root_path
    click_on "Admin Panel"
    click_on "Manage Employees"
    click_on "Edit"
    click_on "Edit Login Info"
		fill_in 'Email', with: 'edited@example.dev'
		click_on "Update User"
    page.should have_content("User successfully updated")
    page.should have_content("edited@example.dev")
  end 

end
