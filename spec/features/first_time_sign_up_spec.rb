require 'spec_helper'

feature "[First Time Signup]" do
  background do
    Capybara.app_host = "http://hrmage.dev:#{Capybara.server_port}"
  end

  
  scenario "Sign up for the first time" do
    sign_up_step
    create_organization_step
    create_department_step
    create_position_step
    create_leave_type_step
    create_profile_step
    payment_step
    summary_step
  end 

  scenario "fail create organization step" do
    sign_up_step
    
    #add your organization part
    page.should have_content("Add your organization")
    click_on "Next Step"
    page.should have_content("Please fill in the required field")
  end

  scenario "fail add department step" do
    sign_up_step
    create_organization_step
    
    #add department part
    page.should have_content("Add departments for your organization")
    click_on "Next Step"
    page.should have_content("There must be at least one department")
  end
  
  scenario "fail add position step" do
    sign_up_step
    create_organization_step
    create_department_step
    
    #add position 
    page.should have_content("Add Position")
    fill_in "Name", with: "Executive"
    click_on "Next Step"
    page.should have_content("Please fill in the required field")
  end
  
  scenario "fail add leave type step" do 
    sign_up_step
    create_organization_step
    create_department_step
    create_position_step
    page.should have_content("Add Leave Type")
    click_on "Next Step"
    page.should have_content("Please fill in the required field")
  end
  
  scenario "fail create profile step" do
    sign_up_step
    create_organization_step
    create_department_step
    create_position_step
    create_leave_type_step
    page.should have_content("Please tell us more about yourself")
    click_on "Next Step"
    page.should have_content("Please fill in the required field")
  end 
end
