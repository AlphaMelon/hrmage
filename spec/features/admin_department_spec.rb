require 'spec_helper'

feature "[Admin Department]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Department" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Department"
    click_on "Show"
    page.should have_content("Account")
  end 
  
  scenario "Add New Department and then delete it" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Department"
    click_on "new_department"
		fill_in 'Name', with: 'Sales'
		click_on "Create Department"
    page.should have_content("Department successfully created")
    page.should have_content("Sales")
 
    all('#delete_department')[1].click
    page.should have_content("Department successfully deleted")

    #what if i delete a department that still has employee?
    click_on "delete_department"
    page.should have_content("You cannot delete department with employee in it.")
     
  end

  scenario "Edit Department" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Department"
    click_on "Edit"
		fill_in 'Name', with: 'Edited Sales'
		click_on "Update Department"
    page.should have_content("Department successfully updated")
    page.should have_content("Edited Sales")
  end

  scenario "submit department without filling form" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Department"
    click_on "new_department"
		click_on "Create Department"
    page.should have_content("can't be blank")
  end
  
end
