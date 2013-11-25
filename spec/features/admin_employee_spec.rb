require 'spec_helper'

feature "[Admin Login]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Show Employee" do
    visit root_path
    click_on "Admin Panel"
    click_on "Manage Employees"
    click_on "Show"
    page.should have_content("spree@example.com")
  end 
  
  scenario "Add New Employee" do
    visit root_path
    click_on "Admin Panel"
    click_on "Manage Employees"
    click_on "New Employee"
    page.should have_content("spree@example.com")
  end 
end
