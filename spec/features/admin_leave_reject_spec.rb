require 'spec_helper'

feature "[Admin approve leave]" do
  background do
    admin_login("spree@example.com", "spree123")
  end
  
  scenario "Approve Leave" do
    visit root_path
    click_on "organization_leaves"
    click_on "Reject"
    page.should have_content("Leaves request rejected")
  end

end
