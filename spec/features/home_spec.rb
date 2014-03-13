require 'spec_helper'

feature "[Home]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "View My Profile" do
    visit root_path
    click_on "View My Profile"
    page.should have_content("spree@example.com")
  end 
  
  scenario "Change My Password" do
    visit root_path
    click_on "Change my password"
		fill_in 'account_password', with: 'spree1234'
		fill_in 'account_password_confirmation', with: 'spree1234'
		fill_in 'account_current_password', with: 'spree123'
		click_on "Update"
    page.should have_content("You updated your account successfully.")
  end
  
end
