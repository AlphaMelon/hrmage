class ClaimSubjectsController < ApplicationController
	before_action :set_organization
	before_action :set_claim_subject, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  load_and_authorize_resource
  
  def index
    @claim_subjects = current_organization.claim_subjects
  end
  
  def new
    @claim_subject = current_organization.claim_subjects.new
  end 

  def create
    @claim_subject = current_organization.claim_subjects.new(claim_subject_params)
    if @claim_subject.save
      redirect_to organization_claim_subjects_path(current_organization), notice: "Claim subject successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @claim_subject.update(claim_subject_params)
			redirect_to organization_claim_subjects_path(current_organization), notice: 'Claim subject successfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
	  @claim_subject.destroy
	  redirect_to organization_claim_subjects_path, notice: 'Claim subject successfully deleted'
	end

  private
	
	def set_claim_subject
	  @claim_subject = ClaimSubject.find(params[:id])
	end

	def set_organization
	  @organization = Organization.find(params[:organization_id])
	end

	def claim_subject_params
		params.require(:claim_subject).permit(:name, :organization_id)
	end
end
