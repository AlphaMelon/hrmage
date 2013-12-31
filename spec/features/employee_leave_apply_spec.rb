require 'spec_helper'

feature "[Admin Position]" do
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


end
