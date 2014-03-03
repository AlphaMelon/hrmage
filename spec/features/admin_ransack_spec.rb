require 'spec_helper'

feature "[Admin search using ransack]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "search Leave" do
    visit root_path
    click_on "Admin"
    click_on "organization_leaves"
    fill_in "q_start_date_gteq", with: Date.today
    click_on "Search"
    page.should have_content(Date.today)
    page.should have_content("David")
  end

  scenario "search Claims" do
    visit root_path
    click_on "Admin"
    click_on "organization_claims"
    select "Petrol", from: "Subject"
    click_on "Search"
    page.should have_content(Date.today)
    page.should have_content("David")
  end

  scenario "search employee" do 
    visit root_path
    click_on "Admin"
    click_on "Employee"
    fill_in "q_last_name_cont", with: "Wong"
    click_on "Search"
    page.should have_content("Wong")
    page.should have_content("STN001")
  end

end
