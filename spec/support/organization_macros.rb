module OrganizationMacros

  def create_organization
    organization_attr = FactoryGirl.attributes_for(:organization)
    organization = Organization.new(organization_attr)
    organization.save
  end

  def create_organization_with_parameter(name, country, currency)
    organization = Organization.new
    organization.name = name
    organization.default_currency = "myr"
    organization.country = country
    organization.save
  end
    
end
