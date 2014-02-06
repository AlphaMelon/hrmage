require 'spec_helper'

feature "[Admin payslip]" do
  background do
    admin_login("spree@example.com", "spree123")
  end

  scenario "Show payslip setting" do
    visit root_path
    click_on "Admin"
    click_on "Salary"
    page.should have_content("Payslip Setting")
  end

  scenario "Add new payslip setting" do
    visit root_path
    click_on "Admin"
    click_on "Salary"
    click_on "Add New Payslip Settings"
    fill_in "Name", with: 'epf'
    fill_in "Value", with: '1000'
    fill_in "Maths", with: 'add'
    click_button "Create Payslip setting"
    page.should have_content("Payslip Setting successfully created")
  end

  scenario "Edit payslip setting" do
    visit root_path
    click_on "Admin"
    click_on "Salary"
    click_on "Edit"
    fill_in "Name", with: 'socso'
    click_button "Update Payslip setting"
    page.should have_content("Payslip Setting successfully update")
  end

end