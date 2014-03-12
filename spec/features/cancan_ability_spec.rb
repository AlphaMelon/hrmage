require 'spec_helper'

feature "[CanCan Ability]" do
  background do
    @acc_org = create_employee_cancan("testing@example.dev", "spree123", true, false, "IT")
    admin_login("testing@example.dev", "spree123")
  end
  
  scenario "Read Claim Subject without permission" do
    visit organization_claim_subjects_path(Organization.first)
    page.should have_content("Access denied")
  end
  
end
