require 'spec_helper'

feature "[Admin Claim Subject]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Claim Subject" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Claim Subjects"
    page.should have_content("Petrol")
  end 
  
  scenario "Add New claim subject" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Claim Subjects"
    click_on "Add new claim subject"
		fill_in 'Name', with: 'Entertainment'
		click_on "Create Claim subject"
    page.should have_content("Claim subject successfully created")
    page.should have_content("Entertainment")
  end

  scenario "Delete claim subject" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Claim Subjects"
    click_on "delete_claim_subject"
    page.should have_content("Claim subject successfully deleted")
    page.should_not have_content("Petrol")
  end

  scenario "Edit Position" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Claim Subjects"
    click_on "Edit"
		fill_in 'Name', with: 'Edited subject'
		click_on "Update Claim subject"
    page.should have_content("Claim subject successfully updated")
    page.should have_content("Edited subject")
  end

  scenario "submit position form without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "My Organization"
    click_on "Claim Subjects"
    click_on "Add new claim subject"
		click_on "Create Claim subject"
    page.should have_content("can't be blank")
  end

end
