require 'spec_helper'

feature "[CanCan Ability Leave Type]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Leave Type without permission" do
    visit organization_leave_types_path(Organization.first)
    page.should have_content("Access denied")
  end
  
  scenario "Read Leave Type with permission" do
    @acc_org.leave_type = "Read Only"
    @acc_org.save
    visit organization_leave_types_path(Organization.first)
    page.should_not have_content("Access denied")
  end
  
  scenario "Create Leave Type without permission" do
    @acc_org.leave_type = "Read Only"
    @acc_org.save
    visit organization_leave_types_path(Organization.first)
    click_on "new_leave_type"
    page.should have_content("Access denied")
  end
  
  scenario "Create Leave Type with permission" do
    @acc_org.leave_type = "Read and Create"
    @acc_org.save
    visit organization_leave_types_path(Organization.first)
    click_on "new_leave_type"
    page.should_not have_content("Access denied")
  end
  
  scenario "Edit Leave Type without permission" do
    @acc_org.leave_type = "Read and Create"
    @acc_org.save
    visit organization_leave_types_path(Organization.first)
    click_on "edit_leave_type"
    page.should have_content("Access denied")
  end
  
  scenario "Edit Leave Type with permission" do
    @acc_org.leave_type = "Read and Update"
    @acc_org.save
    visit organization_leave_types_path(Organization.first)
    click_on "edit_leave_type"
    page.should_not have_content("Access denied")
  end

end
