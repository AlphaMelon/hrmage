require 'spec_helper'

feature "[CanCan Ability Position]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Position without permission" do
    visit organization_positions_path(Organization.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Position with permission" do
    @acc_org.position = "Read Only"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Position without permission" do
    @acc_org.position = "Read Only"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    click_on "new_position"
    page.should have_content("Access denied")
  end
  
  scenario "Create Position with permission" do
    @acc_org.position = "Read and Create"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    click_on "new_position"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Position without permission" do
    @acc_org.position = "Read and Create"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    click_on "edit_position"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Position with permission" do
    @acc_org.position = "Read and Update"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    click_on "edit_position"
    page.should_not have_content("Access denied")
  end
  
  scenario "Delete Position without permission" do
    @acc_org.position = "Read and Create"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    click_on "delete_position"
    page.should have_content("Access denied")
  end
  
  scenario "Delete Position with permission" do
    @acc_org.position = "Manage all"
    @acc_org.save
    visit organization_positions_path(Organization.first)
    click_on "edit_position"
    page.should_not have_content("Access denied")
  end  
end
