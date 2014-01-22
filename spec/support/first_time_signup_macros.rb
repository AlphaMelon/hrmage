module FirstTimeSignupMacros


    def sign_up_step
      #sign up part
      visit new_account_registration_path
      fill_in "Email", with: "example@example.dev"
      fill_in "account_password", with: "spree123"
      fill_in "account_password_confirmation", with: "spree123"
      click_on "Sign up"
      page.should have_content("Welcome! You have signed up successfully.")
    end

    def create_organization_step
      #add your organization part
      page.should have_content("Add your organization")
      fill_in "Name", with: "testing"
      click_on "Next Step"
      page.should have_content("Organization saved!")
    end
    
    def create_department_step
      #add department part
      page.should have_content("Add departments for your organization")
      fill_in "department_1", with: "Account"
      fill_in "department_2", with: "Marketing"
      fill_in "department_3", with: "IT"
      click_on "Next Step"
      page.should have_content("Department saved!")
    end
    
    def create_position_step
      #add position 
      page.should have_content("Add position")
      fill_in "Name", with: "Executive"
      fill_in "position_max_leaves_seconds", with: 1234567
      fill_in "position_max_claims", with: 1234567
      click_on "Next Step"
      page.should have_content("Position")
    end
    
    def create_leave_type_step
      #add leave type 
      page.should have_content("Add Leave Type")
      fill_in "Name", with: "Medical"
      select "Leave", from: "leave_type_affected_entity"
      fill_in "Description", with: "Medical Leave"
      fill_in "leave_type_colour", with: "#f3f3f3"
      click_on "Next Step"
      page.should have_content("Leave type saved!")
    end
    
    def create_profile_step
      #tell us more about yourself part
      page.should have_content("Please tell us more about yourself.")
      fill_in "Last Name", with: "Wong"
      fill_in "First Name", with: "David"
      fill_in "Mobile Contact", with: "016-31413254"
      fill_in "Address", with: "Klang"
      click_on "Next Step"
      page.should have_content("Your profile is created")
    end
    
    def payment_step
      #payment part
      click_on "Skip"
      page.should have_content("Finish! Take a look at your organization!")
    end
    
    def summary_step
      #summary part
      page.should have_content("example@example.dev")
      page.should have_content("testing")
      page.should have_content("Account")
      page.should have_content("Marketing")
      page.should have_content("Position")
      page.should have_content("Medical")
    end

end
