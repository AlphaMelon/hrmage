module AdminUserMacros

  def create_admin_user
    @admin_user_attr = FactoryGirl.attributes_for(:admin_user)
    @admin_user = AdminUser.create!(@admin_user_attr)
  end
  
  def create_admin_user_with_parameter(email, password)
    admin = AdminUser.new(email: email, password: password)
    admin.save
  end
  def active_admin_login(email, password)
    #visit new_admin_user_session_path
    #raise current_url.inspect
    visit "http://staff.alphamelon.dev/admin"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Login"
    page.should have_content("Signed in successfully.")
  end
  

end
