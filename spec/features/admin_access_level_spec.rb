require 'spec_helper'

feature "[Admin Access Level]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Access level" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Edit Login Info"
    click_on "More Access Level"
    page.should have_content("No Access")
    page.should have_content("Leave")
  end 
  
  scenario "Add New Access Level" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Edit Login Info"
    click_on "More Access Level"
    click_on "new_access_level"
    click_on "Create Access level"
    page.should have_content("Access Level successfully created")
    page.should have_content("No Access")
  end

  scenario "Delete Access Level" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Edit Login Info"
    click_on "More Access Level"
    click_on "delete_access_level"
    page.should have_content("Access Level successfully deleted")
    page.should_not have_content("No Access")
  end

  scenario "Edit Access level" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Edit"
    click_on "Edit Login Info"
    click_on "More Access Level"
    click_on "edit_access_level"
		select "Read and Update", from: "Access level" 
		click_on "Update Access level"
    page.should have_content("Access Level successfully updated")
    page.should have_content("Read and Update")
  end

end
