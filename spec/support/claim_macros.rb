module ClaimMacros

  def create_claim
    @claim_attr = FactoryGirl.attributes_for(:claim)
    @claim = Claim.new(@claim_attr)
    @claim.organization = Organization.first
    @claim.employee = Employee.first
    @claim.save
  end

  
end
