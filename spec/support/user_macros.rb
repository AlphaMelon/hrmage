module UserMacros

  def create_admin_user
    @user_attr = FactoryGirl.attributes_for(:user)
    @user = User.create!(@user_attr)
    @employee_attr = FactoryGirl.attributes_for(:employee)
    employee = Employee.create!(@employee_attr)
    employee.user_id = @user.id
    employee.save
  end
  
  def admin_login(email, password)
    visit new_user_session_path
    click_on "Sign In"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Sign in"
    page.should have_content("Signed in successfully.")
  end
  
  def sign_up_user(email, password)
    visit new_user_registration_path
    fill_in "Email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_on "Sign up"
    page.should have_content("Welcome! You have signed up successfully.")
  end
  
end
