module OrganizationMacros

  def create_organization
    organization_attr = FactoryGirl.attributes_for(:organization)
    organization = Organization.create!(organization_attr)
  end

  
end
