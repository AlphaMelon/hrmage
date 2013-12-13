class DocumentsController < ApplicationController
  before_action :set_organization
	before_action :set_employee
	before_action :set_document, only: [:edit, :update, :destroy]
	before_filter :authenticate_account!
  
  def new
    @document = @employee.documents.new
  end 

  def create
    @document = @employee.documents.new(document_params)
    if @document.save
      redirect_to organization_employee_path(@organization, @employee), notice: "Document successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @document.update(document_params)
			redirect_to organization_employee_path(@organization, @employee), notice: 'Document successfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
		@document.destroy
		redirect_to organization_employee_path(@organization, @employee), notice: 'Document successfully deleted'
	end

  private
  
	def set_organization
		@organization = Organization.find(params[:organization_id])
	end
	
	def set_employee
		@employee = Employee.find(params[:employee_id])
	end
	
	def set_document
	  @document = Document.find(params[:id])
	end

	def document_params
		params.require(:document).permit(:name, :image)
	end
end
