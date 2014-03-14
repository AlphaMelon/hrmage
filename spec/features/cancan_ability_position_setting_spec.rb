require 'spec_helper'

feature "[CanCan Ability Position Setting]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Position Setting without permission" do
    visit organization_position_position_settings_path(Organization.first, Position.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Position Setting with permission" do
    @acc_org.position = "Read Only"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Position Setting without permission" do
    @acc_org.position = "Read Only"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    click_on "new_position_setting"
    page.should have_content("Access denied")
  end
  
  scenario "Create Position Setting with permission" do
    @acc_org.position = "Read and Create"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    click_on "new_position_setting"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Position Setting without permission" do
    @acc_org.position = "Read and Create"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    click_on "edit_position_setting"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Position Setting with permission" do
    @acc_org.position = "Read and Update"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    click_on "edit_position_setting"
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Position Setting without permission" do
    @acc_org.position = "Read and Create"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    click_on "delete_position_setting"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Position Setting with permission" do
    @acc_org.position = "Manage all"
    @acc_org.save
    visit organization_position_position_settings_path(Organization.first, Position.first)
    click_on "edit_position_setting"
    page.should_not have_content("Access denied")
  end  
end
