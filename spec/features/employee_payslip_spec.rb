require 'spec_helper'

feature "[Employee Claims]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Payslip index" do
    visit root_path
    click_on "my_salary", match: :first
    page.should have_content("My Salary")
    page.should have_content("3,000")
  end

  scenario "Payslip index" do
    visit root_path
    click_on "my_salary", match: :first
    click_on "show_my_salary"
    page.should have_content("David wong (")
    page.should have_content("3,000")
  end

end
