require 'spec_helper'

feature "[First Time Signup]" do

  
  scenario "Sign up for the first time" do
  
    #sign up part
    visit new_account_registration_path
    fill_in "Email", with: "example@example.dev"
    fill_in "account_password", with: "spree123"
    fill_in "account_password_confirmation", with: "spree123"
    click_on "Sign up"
    page.should have_content("Welcome! You have signed up successfully.")
    
    #add your organization part
    page.should have_content("Add your organization")
    fill_in "Name", with: "Microsoft Sdn Bhd"
    fill_in "Domain", with: "microsoft.dev"
    click_on "Next Step"
    page.should have_content("Organization saved!")

    #add department part
    page.should have_content("Add departments for your organization")
    fill_in "department_1", with: "Account"
    fill_in "department_2", with: "Marketing"
    fill_in "department_3", with: "IT"
    click_on "Next Step"
    page.should have_content("Department saved!")
    
    #tell us more about yourself part
    page.should have_content("Please tell us more about yourself.")
    fill_in "Last name", with: "Wong"
    fill_in "First name", with: "David"
    fill_in "Mobile contact", with: "016-31413254"
    fill_in "Address", with: "Klang"
    click_on "Next Step"
    page.should have_content("Congratulation! Have a look at your Organization!")
    
    #add new staff part
    #page.should have_content("Add a new staff")
    #fill_in "Last name", with: "Lee"
    #fill_in "First name", with: "Anton"
    #fill_in "Mobile contact", with: "017-31413254"
    #fill_in "Address", with: "Petaling"
    #fill_in "Email", with: "testing@example.dev"
    #fill_in "Password", with: "spree123"
    #click_on "Finish"
    #page.should have_content("Congratulation! Have a look at your Organization!")
    
    #summary part
    page.should have_content("example@example.dev")
    page.should have_content("Microsoft Sdn Bhd")
    page.should have_content("Account")
    page.should have_content("Marketing")
    #page.should have_content("testing@example.dev")
  end 
  
end
