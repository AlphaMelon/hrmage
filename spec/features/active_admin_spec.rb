require 'spec_helper'

feature "[Active Admin]" do
  background do
    active_admin_login("admin@example.com", "spree123")
  end
  
  scenario "View Admin Users" do
    click_on "Admin Users"
    page.should have_content("admin@example.com")
  end
  
  scenario "Edit admin user" do
    click_on "Admin Users"
    click_on "Edit"
    fill_in "admin_user_password", with: "password2"
    fill_in "admin_user_password_confirmation", with: "password2"
    click_on "Update Admin user"
    
    fill_in "Email", with: "admin@example.com"
    fill_in "Password", with: "password2"
    click_on "Login"
    page.should have_content("Signed in successfully.")
  end
  
  scenario "add new admin user and then delete it" do 
    click_on "Admin Users"
    click_on "New Admin User"
    fill_in "admin_user_email", with: "admin2@example.com"
    fill_in "admin_user_password", with: "password2"
    fill_in "admin_user_password_confirmation", with: "password2"
    click_on "Create Admin user"
    page.should have_content("admin2@example.com")
    page.should have_content("Admin user was successfully created.")
    
    click_on "Delete Admin User"
    page.should have_content("Admin user was successfully destroyed.")
  end
  
  scenario "submit new admin user form without filling in anything" do
    click_on "Admin Users"
    click_on "New Admin User"
    click_on "Create Admin user"
    page.should have_content("can't be blank")
  end
  
  scenario "edit country holiday settings" do
    click_on "Country Holiday Settings"
    click_on "Edit"
    select "Malaysia", from: "country_holiday_setting_country_setting_id"
    fill_in "country_holiday_setting_name", with: "Cow Day"
    select Date.today.year, from: "country_holiday_setting_date_1i"
    select "August", from: "country_holiday_setting_date_2i"
    select "25", from: "country_holiday_setting_date_3i"
    click_on "Update Country holiday setting"
    page.should have_content("Country holiday setting was successfully updated.")
  end
  
  scenario "add country holiday setting and then delete it" do
    click_on "Country Holiday Settings"
    click_on "New Country Holiday Setting"
    select "Malaysia", from: "country_holiday_setting_country_setting_id"
    fill_in "country_holiday_setting_name", with: "Sheep Day"
    select Date.today.year, from: "country_holiday_setting_date_1i"
    select "August", from: "country_holiday_setting_date_2i"
    select "25", from: "country_holiday_setting_date_3i"
    click_on "Create Country holiday setting"
    page.should have_content("Sheep Day")
    page.should have_content("Country holiday setting was successfully created.")
    
    click_on "Delete Country Holiday Setting"
    page.should have_content("Country holiday setting was successfully destroyed.")
  end

  scenario "submit country holiday setting form without filling in anything" do
    click_on "Country Holiday Settings"
    click_on "New Country Holiday Setting"
    click_on "Create Country holiday setting"
    page.should have_content("can't be blank")
  end
end
