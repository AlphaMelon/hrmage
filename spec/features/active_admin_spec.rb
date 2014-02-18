require 'spec_helper'

feature "[Active Admin]" do
  background do
    #admin_login("spree@example.com", "spree123")
    active_admin_login("admin@example.com", "spree123")
  end
  
  scenario "Approve Claim" do
    visit admin_root_path
    click_on "Admin Users"
    page.should have_content("admin@example.com")
  end

end
