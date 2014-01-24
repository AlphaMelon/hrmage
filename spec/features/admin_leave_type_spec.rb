require 'spec_helper'

feature "[Admin Leave Type]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Leave Type" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Leave Types"
    page.should have_content("Annual leave")
  end 
  
  scenario "Add New Leave Type" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Leave Types"
    click_on "Add New Leave Type"
		fill_in 'Name', with: 'Medical leave'
		select "Yes", from: "leave_type_approval_needed"
		select "Leave", from: "leave_type_affected_entity"
		select "Substraction", from: "Type"
		fill_in "Description", with: "Sick leaves"
		fill_in "Colour", with: "#f4f4f4"
		click_on "Create Leave type"
    page.should have_content("Leave type successfully created")
    page.should have_content("Medical leave")
  end

  scenario "Edit Leave Type" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Leave Types"
    click_on "Edit"
		fill_in 'leave_substraction_name', with: 'Edited leave'
		click_on "Update Leave substraction"
    page.should have_content("Leaves type succesfully updated")
    page.should have_content("Edited leave")
  end

  scenario "submit Leave Type form without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Leave Types"
    click_on "Add New Leave Type"
		click_on "Create Leave type"
    page.should have_content("Please fill in the required field")
  end
  
end
