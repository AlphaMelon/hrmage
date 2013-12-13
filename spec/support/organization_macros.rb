module OrganizationMacros

  def create_organization
    @organization_attr = FactoryGirl.attributes_for(:document)
    @organization = Organization.create!(@organization_attr)
    
    @account = Account.first
    @account_organization = AccountOrganization.new(account_id: @account.id, organization_id: @organization.id, role: "Admin")
    @account_organization.save
    
    @employee_attr = FactoryGirl.attributes_for(:employee)
    @employee = Employee.create!(@employee_attr)
    @employee.account_id = @account.id
    @employee.organization_id = @organization.id
    @employee.save
  end

  
end
