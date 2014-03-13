require 'spec_helper'

feature "[Admin Organization Holiday]" do
  background do
    admin_login("spree@example.com", "spree123")
    create_organization_setting
  end
  
  scenario "Show holiday" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Organization Holidays"
    data_obj('holiday-index','header').should have_content("holiday list") 
    page.should have_content("holiday list")
  end
  
  scenario "Add Holiday" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Organization Holidays"
    click_on "new_organization_holiday"
    fill_in 'Name', with: "Deepavali"
    fill_in "Date", with: Date.today.to_s
    click_on "Create Organization holiday"
    page.should have_content("Organization holiday successfully created")
    page.should have_content("Deepavali")
  end  
  
  scenario "Edit holiday" do
    create_organization_holiday
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Organization Holidays"
    click_on "Edit"
		fill_in 'Name', with: "Edited holiday"
		click_on "Update Organization holiday"
		page.should have_content("Organization holiday successfully updated")
    page.should have_content("Edited holiday")
  end
  
  scenario "delete holiday" do
    create_organization_holiday
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Organization Holidays"
    click_on "Delete"
    page.should have_content("Organization holiday successfully deleted")
  end

  scenario "submit form without any parameter" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Organization Holidays"
    click_on "new_organization_holiday"
    click_on "Create Organization holiday"
    page.should have_content("can't be blank")
  end
  
  scenario "Get and update new default holiday" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Organization Holidays"
    click_on "Get and update new default holiday for your organization"
    page.should have_content("Organization holidays successfully updated.")
    page.should have_content("Christmas")
  end
end
