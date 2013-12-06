module DocumentMacros

  def create_document
    @document_attr = FactoryGirl.attributes_for(:document)
    @document = Document.create!(@document_attr)
    @document.employee = User.first.employee
    @document.save
  end

  
end
