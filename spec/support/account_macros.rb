module AccountMacros

  def create_admin_account
    @account_attr = FactoryGirl.attributes_for(:account)
    @account = Account.create!(@account_attr)
  end
  
  def admin_login(email, password)
    visit new_account_session_path
    click_on "Sign In"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Sign in"
    page.should have_content("Signed in successfully.")
  end
  
  def sign_up_account(email, password)
    visit new_account_registration_path
    fill_in "Email", with: email
    fill_in "account_password", with: password
    fill_in "account_password_confirmation", with: password
    click_on "Sign up"
    page.should have_content("Welcome! You have signed up successfully.")
  end
  
end
