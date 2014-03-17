module AccessLevelMacros

  def create_access_level
    @access_level_attr = FactoryGirl.attributes_for(:access_level)
    @access_level = AccessLevel.new(@access_level_attr)
    @access_level.account_organization_id = AccountOrganization.first.id
    @access_level.department_id = Department.first.id
    @access_level.save
  end

  
end
