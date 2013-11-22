require 'spec_helper'

feature "[Admin Login]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "View My Profile" do
    visit root_path
    click_on "View My Profile"
    page.should have_content("spree@example.com")
  end 
  

end
