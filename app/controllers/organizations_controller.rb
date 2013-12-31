class OrganizationsController < ApplicationController
	before_action :set_organization, only: [:show, :edit, :update]
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	
	def index
	  @organizations = current_account.organizations
	end
  
  def show
  end
  
  def new
    @organization = Organization.new
  end 

  def create
    @organization = Organization.new(organization_params)
    
    if @organization.save
    
      account_organization = AccountOrganization.new
      account_organization.organization_id = @organization.id
      account_organization.account_id = current_account.id
      account_organization.role = "Admin"
      account_organization.save
      
      redirect_to organization_path(@organization), notice: "Organization successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  
  end
  
  def update
		if @organization.update(organization_params)
			redirect_to organization_path(@organization), notice: 'Organization successfully updated'
		else
			render action: 'edit'
		end
  end
  
  private
  
	def set_organization
		@organization = Organization.find(params[:id])
	end

	def organization_params
		params.require(:organization).permit(:name, :domain)
	end
end
