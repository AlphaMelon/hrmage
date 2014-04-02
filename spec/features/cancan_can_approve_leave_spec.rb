require 'spec_helper'

feature "[CanCan Ability Leaves]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    @access_level = @acc_org.access_levels.first
    admin_login("testing@example.dev", "spree123")
  end

  scenario "Approve Leave without authority" do
    @access_level.class_name = "Claim"
    @access_level.save
    visit organization_leaves_path(Organization.first)
    click_on "Approve"
    page.should have_content("Access denied")
  end
  
  scenario "Approve leave with authority" do
    @access_level.class_name = "Leave"
    @access_level.access_level = "Read and Update"
    @access_level.department_id = Department.last.id
    @access_level.save
    
    visit organization_leaves_path(Organization.first)
    click_on "Approve"
    page.should have_content("Leaves request approved")
  end
  
  scenario "Approve Own Leave with authority" do
    Leave.delete_all
    @acc_org.can_self_approve = true
    @acc_org.save
    
    @access_level.class_name = "Leave"
    @access_level.department_id = Department.last.id
    @access_level.save
    
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    visit organization_leaves_path(Organization.first)
    #all('#approve_leave')[0].click
    click_on("approve_leave")
    page.should have_content("Leaves request approved")
  end
  
  scenario "Approve Own Leave without authority" do
    @acc_org.can_self_approve = false
    @acc_org.save
    
    visit root_path
    click_on "Leaves", match: :first
    click_on "Apply Leave"
    fill_in "leave_start_date", with: "2014-01-27 00:00"
    fill_in "leave_duration_seconds", with: 3
    click_button "Apply Leave"
    page.should have_content("Leave successfully applied, please wait for admin to approve")
    
    visit organization_leaves_path(Organization.first)
    all('#approve_leave')[1].click
    page.should have_content("Access denied")
  end
end
