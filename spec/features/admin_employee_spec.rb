require 'spec_helper'

feature "[Admin Employee]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Employee" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "Show"
    page.should have_content("spree@example.com")
  end 
  
  scenario "Add New Employee" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "New Employee"
		fill_in 'Last name', with: 'Lee'
		fill_in 'First name', with: 'Alan'
		fill_in 'Mobile contact', with: '016-3134415'
		fill_in 'Address', with: 'klang'
		click_on "Create Employee"
    page.should have_content("Employee successfully created")
    page.should have_content("Lee")
  end

  scenario "Edit Employee" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "Edit"
		fill_in 'Last name', with: 'Edited Wong'
		click_on "Update Employee"
    page.should have_content("Employee successfully updated")
    page.should have_content("Edited Wong")
  end

  scenario "Edit login info" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "Edit"
    click_on "Edit Login Info"
		fill_in 'Email', with: 'edited@example.dev'
		click_on "Update Account"
    page.should have_content("Account successfully updated")
    page.should have_content("edited@example.dev")
  end 

  scenario "Add login info" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "New Employee"
		fill_in 'Last name', with: 'Lee'
		fill_in 'First name', with: 'Alan'
		fill_in 'Mobile contact', with: '016-3134415'
		fill_in 'Address', with: 'klang'
		click_on "Create Employee"
    page.should have_content("Employee successfully created")
    page.should have_content("Lee")

    #click_on "Edit"
    find(:xpath, "(//a[text()='Edit'])[2]").click
    click_on "Add Login"
		fill_in 'Email', with: 'newlogin@example.dev'
		fill_in 'Password', with: 'spree123'
		click_on "Create Account"
    page.should have_content("Login successfully added")
    page.should have_content("newlogin@example.dev")
  end
  
  scenario "Link Department to employee" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "Edit"
    click_on "Add department to this employee"
    page.should have_content("Linking department")
    click_on "Link to employee"
    page.should have_content("Department successfully linked")
  end
  scenario "Remove department link from employee" do
    visit organizations_path
    click_on "Show"
    click_on "Employee list"
    click_on "Edit"
    click_on "Remove link"
    page.should have_content("Department link removed from employee")
  end
end
