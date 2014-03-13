require 'spec_helper'

feature "[Admin payslip]" do
  background do
    admin_login("spree@example.com", "spree123")
  end

  scenario "Show payslip setting" do
    visit root_path
    click_on "Admin"
    click_on "Payslip Setting"
    page.should have_content("Payslip Setting")
  end

  scenario "Add new payslip setting and then delete it" do
    visit root_path
    click_on "Admin"
    click_on "Payslip Setting"
    click_on "new_payslip_setting"
    fill_in "Name", with: 'epf'
    fill_in "Value", with: '1000'
    select "Addition", from: 'Maths'
    click_button "Create Payslip setting"
    page.should have_content("Payslip Setting successfully created")
    
    all('#delete_payslip_setting')[1].click
    page.should have_content("Payslip setting successfully deleted")

    #what if i delete a setting that is still being used?
    click_on "delete_payslip_setting"
    page.should have_content("You cannot delete this setting because it is being used for payslips.")    
  end

  scenario "Edit payslip setting" do
    visit root_path
    click_on "Admin"
    click_on "Payslip Setting"
    click_on "Edit"
    fill_in "Name", with: 'socso'
    click_button "Update Payslip setting"
    page.should have_content("Payslip Setting successfully update")
  end

  scenario "submit payslip setting without filling in anything" do
    visit root_path
    click_on "Admin"
    click_on "Payslip Setting"
    click_on "new_payslip_setting"
    click_button "Create Payslip setting"
    page.should have_content("can't be blank")
  end

end
