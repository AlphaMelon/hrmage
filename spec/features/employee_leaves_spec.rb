require 'spec_helper'

feature "[Employee Leaves]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Apply Leave" do
    visit root_path
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
  end
  
  scenario "Applying leave more than your available leaves" do
    visit root_path
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 100
    click_button "Apply Leave"
    page.should have_content("is more than your available leaves")
  end

  scenario "Leave remaining progress bar" do
    #12 out of 14 leave days remaining
    #approve leave of 2 days
    visit root_path
    click_on "organization_leaves"
    click_on "Approve"
    page.should have_content("Leaves request approved")
    
    #progress bar should be 10 out of 14 leaves days
    #visit my_leaves_path
    click_on "My Leaves"
    page.should have_content("10/14")
  end

end
