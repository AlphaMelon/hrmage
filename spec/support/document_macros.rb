module DocumentMacros

  def create_document
    @document_attr = FactoryGirl.attributes_for(:document)
    @document = Document.create!(@document_attr)
    @document.employee_id = Account.first.profiles.where(organization_id: Organization.first.id).first.id
    @document.save
  end

  
end
