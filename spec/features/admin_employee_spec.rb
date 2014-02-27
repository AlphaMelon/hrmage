require 'spec_helper'

feature "[Admin Employee]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Employee" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Show"
    page.should have_content("spree@example.com")
  end 
  
  scenario "Add New Employee and then delete it" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Add New Employee"
    fill_in 'Employee identification', with: "STN555"
		fill_in 'Last name', with: 'Lee'
		fill_in 'First name', with: 'Alan'
		fill_in 'Mobile contact', with: '016-3134415'
		fill_in 'Address', with: 'klang'
		fill_in 'Base salary', with: '3000'
		select "Executive", from: "Position"
		click_on "Create Employee"
    page.should have_content("Employee successfully created")
    page.should have_content("Lee")

    all('#delete_employee')[1].click
    page.should have_content("Employee successfully deleted")

    #what if i delete a super admin employee?
    click_on "delete_employee"
    page.should have_content("Super Admin employee cannot be deleted.")
    

  end

  scenario "Edit Employee" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
		fill_in 'Last name', with: 'Edited Wong'
		click_on "Update Employee"
    page.should have_content("Employee successfully updated")
    page.should have_content("Edited Wong")
  end
  
  scenario "submit employee form without filling anything" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Add New Employee"
		click_on "Create Employee"
    page.should have_content("can't be blank")
  end
  
  scenario "Edit login info" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Edit Login Info"
		fill_in 'Email', with: 'edited@example.dev'
		click_on "Update Account"
    page.should have_content("Account successfully updated")
    page.should have_content("edited@example.dev")
  end 

  scenario "Add login info" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Add New Employee"
    fill_in 'Employee identification', with: "STN444"
		fill_in 'Last name', with: 'Lee'
		fill_in 'First name', with: 'Alan'
		fill_in 'Mobile contact', with: '016-3134415'
		fill_in 'Address', with: 'klang'
		fill_in 'Base salary', with: '3000'
		select "Executive", from: "Position"
		click_on "Create Employee"
    page.should have_content("Employee successfully created")
    page.should have_content("Lee")

    #click_link "edit_employee"
    #find(:xpath, "(//a[id='edit_employee'])[2]").click
    #first(:link, "Edit").click
    #page.all('Edit')[1].click
    all('#edit_employee')[1].click
    
    click_on "Add Login"
		fill_in 'Email', with: 'newlogin@example.dev'
		fill_in 'Password', with: 'spree123'
		click_on "Create Account"
    page.should have_content("Login successfully added")
    page.should have_content("newlogin@example.dev")
  end

  scenario "submit login info without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Add New Employee"
    fill_in 'Employee identification', with: "STN555"
		fill_in 'Last name', with: 'Lee'
		fill_in 'First name', with: 'Alan'
		fill_in 'Mobile contact', with: '016-3134415'
		fill_in 'Base salary', with: '3000'
		fill_in 'Address', with: 'klang'
		select "Executive", from: "Position"
		click_on "Create Employee"
    page.should have_content("Employee successfully created")
    page.should have_content("Lee")

    all('#edit_employee')[1].click
    
    click_on "Add Login"
		click_on "Create Account"
    page.should have_content("Invalid email or password")
  end

  scenario "Link Department to employee" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Add department to this employee"
    page.should have_content("Link Department to")
    click_on "Link to employee"
    page.should have_content("Department successfully linked")
  end
  scenario "Remove department link from employee" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Remove Link"
    page.should have_content("Department link removed from employee")
  end
end
