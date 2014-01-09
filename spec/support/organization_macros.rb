module OrganizationMacros

  def create_organization
    organization_attr = FactoryGirl.attributes_for(:organization)
    organization = Organization.create!(organization_attr)
  end

  def create_organization_with_parameter(domain, name, currency)
    organization = Organization.new
    organization.name = name
    organization.domain = domain
    organization.default_currency = "myr"
    organization.save
  end
    
end
