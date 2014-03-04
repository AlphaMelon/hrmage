module ClaimSubjectMacros

  def create_claim_subject
    @claim_subject_attr = FactoryGirl.attributes_for(:claim_subject)
    @claim_subject = ClaimSubject.new(@claim_subject_attr)
    @claim_subject.organization = Organization.first
    @claim_subject.save
  end

  
end
