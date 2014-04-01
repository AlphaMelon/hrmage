require 'spec_helper'

feature "[Admin payslip]" do
  background do
    admin_login("spree@example.com", "spree123")
  end

  scenario "Index payslip" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    page.should have_content("Payslip")
  end
  
  scenario "Add new payslip" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "new_payslip"
    fill_in "Date", with: '2014-01-27'
    fill_in "Commission", with: '1000'
    check "EPF"
    click_button "Create Payslip"
    page.should have_content("Payslips successfully created")
  end

  scenario "Edit payslip" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "Edit"
    fill_in "Date", with: '2014-02-01'
    click_on "Update Payslip"
    page.should have_content("Payslips successfully update")
  end

  scenario "Delete payslip" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "Delete"
    page.should have_content("Payslips successfully deleted")
  end

  scenario "submit payslip without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "new_payslip"
    fill_in "Date", with: ''
    click_button "Create Payslip"
    page.should have_content("can't be blank")
  end

  scenario "submit payslip with claim but without filling in start date and end date" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "new_payslip"
    select "Yes", from: "payslip_include_claim"
    click_button "Create Payslip"
    page.should have_content("Claim start and end date cannot be empty")
  end

  scenario "add new payslip with claim without filling in claim start and end date" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "new_payslip"
    fill_in "Date", with: Date.today
    select "Yes", from: "payslip_include_claim"
    click_button "Create Payslip"
    page.should have_content("Claim start and end date cannot be empty")
  end
  
  scenario "add new payslip with affected leave without filling in leave start and end date" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "new_payslip"
    fill_in "Date", with: Date.today
    select "Yes", from: "payslip_include_affected_leave"
    click_button "Create Payslip"
    page.should have_content("Leave start and end date cannot be empty")
  end  
  
  scenario "show payslip" do
    visit root_path
    click_on "Admin"
    click_on "Employee"
    click_on "Payslip"
    click_on "Show"
    page.should have_content("Payslip")
  end
end
