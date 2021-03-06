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
    click_on "new_leave_type"
		fill_in 'Name', with: 'Medical leave'
		select "Yes", from: "leave_type_approval_needed"
		select "Leave", from: "leave_type_affected_entity"
		select "Substraction", from: "Type"
		fill_in "Description", with: "Sick leaves"
		fill_in "Colour", with: "#f4f4f4"
		fill_in "leave_type_default_count_seconds", with: 100
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
    click_on "new_leave_type"
		click_on "Create Leave type"
    page.should have_content("can't be blank")
  end
  
  scenario "Add New Leave Type with affected salary but without division by days" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Leave Types"
    click_on "new_leave_type"
		fill_in 'Name', with: 'Affected salary leave'
		select "Yes", from: "leave_type_approval_needed"
		select "Salary", from: "leave_type_affected_entity"
		fill_in "Description", with: "Sick leaves"
		fill_in "Colour", with: "#f4f4f4"
		fill_in "leave_type_default_count_seconds", with: 100
		click_on "Create Leave type"
    page.should have_content(" Divide by days can't be blank if affected entity includes salary")
  end

  scenario "Add New Leave Type with affected salary but with 0 days" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Leave Types"
    click_on "new_leave_type"
    fill_in 'Name', with: 'Affected salary leave'
    select "Yes", from: "leave_type_approval_needed"
    select "Salary", from: "leave_type_affected_entity"
    fill_in "leave_type_divide_by_days", with: 0
    fill_in "Description", with: "Sick leaves"
    fill_in "Colour", with: "#f4f4f4"
    fill_in "leave_type_default_count_seconds", with: 100
    click_on "Create Leave type"
    page.should have_content("Divide by days can't be be 0 or less then 0")
  end
  
end
