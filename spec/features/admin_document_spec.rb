require 'spec_helper'

feature "[Admin Employee's Document]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
   
  scenario "Add New Document for employee" do
    visit root_path
    click_on "View Employees"
    click_on "Show"
    click_on "New Document"
		fill_in 'Name', with: 'IC'
		click_on "Create Document"
    page.should have_content("Document successfully created")
    page.should have_content("IC")
  end

  scenario "Edit Document" do
    visit root_path
    click_on "View Employees"
    click_on "Show"
    click_on "Edit"
		fill_in 'Name', with: 'Edited IC'
		click_on "Update Document"
    page.should have_content("Document successfully updated")
    page.should have_content("Edited IC")
  end
  
  scenario "Delete Document" do
    visit root_path
    click_on "View Employees"
    click_on "Show"
    click_on "Delete"
    page.should have_content("Document successfully deleted")
    page.should_not have_content("Passport")
  end

end
