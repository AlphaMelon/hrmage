require 'spec_helper'

feature "[Employee Leaves]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Apply Leave" do
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
  end
  
  scenario "Applying leave more than your available leaves" do
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 100
    click_button "Apply Leave"
    page.should have_content("is more than your available leaves")
  end
  
  scenario "Applying leave with negative duration" do
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: -100
    click_button "Apply Leave"
    page.should have_content("cannot be zero or negative")
  end
  
  scenario "Applying leave again with same day" do
    #apply leave
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    #approve leave
    visit root_path
    click_on "Admin"
    click_on "organization_leaves"
    click_on "Approve", match: :first
    page.should have_content("Leaves request approved")
    visit root_path
    click_on "organization_leaves"
    click_on "Approve"
    page.should have_content("Leaves request approved")

    #apply leave again on the same day
    visit root_path
    click_on "Normal"
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("You have leave on the selected day already.")
  end

  scenario "take leave on off day" do
    create_organization_setting
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-26 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("is off day")
  end

  scenario "Leave remaining progress bar" do
    #10 out of 21 leave days remaining
    #approve leave of 3 days
    visit root_path
    click_on "Admin"
    click_on "organization_leaves"
    click_on "Approve"
    page.should have_content("Leaves request approved")
    
    #progress bar should be 7 out of 21 leaves days
    #visit my_leaves_path
    click_on "Normal"
    click_on "my_leaves", match: :first
    page.should have_content("7/21")
  end

  scenario "view calendar" do
    visit root_path
    click_on "my_leaves", match: :first
    click_on "Calendar"
    page.should have_content("Leave Calendar")
  end

end
