module OrganizationMacros

  def create_organization
    @organization_attr = FactoryGirl.attributes_for(:document)
    @organization = Organization.create!(@organization_attr)
    @user = User.first
    @user.organization_id = @organization.id
    @user.save
  end

  
end
