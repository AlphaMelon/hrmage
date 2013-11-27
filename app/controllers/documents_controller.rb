class DocumentsController < ApplicationController
	before_action :set_employee
	before_action :set_document, only: [:edit, :update, :destroy]
	before_filter :authenticate_user!
  
  def new
    @document = @employee.documents.new
  end 

  def create
    @document = @employee.documents.new(document_params)
    
    if @document.save
      redirect_to employee_path(@employee), notice: "Document successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @document.update(document_params)
			redirect_to employee_path(@employee), notice: 'Document successfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
		@document.destroy
		redirect_to employee_path(@employee), notice: 'Document successfully deleted'
	end

  private
  
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
