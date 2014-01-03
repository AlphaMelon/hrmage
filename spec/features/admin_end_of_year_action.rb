require 'spec_helper'

feature "[Admin end of year action]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Carry forward leaves" do
    visit root_path
    click_on "organization_leaves"
    click_on "Carry Forward Employee's Available Leaves"
    page.should have_content("Employee's leaves forwarded")
  end
  
  scenario "forfeit remaining leaves" do
    visit root_path
    click_on "organization_leaves"
    click_on "Reset Employee's Available Leaves"
    page.should have_content("Employee's leaves reseted")
  end
  
end
