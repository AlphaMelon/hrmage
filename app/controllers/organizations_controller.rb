class OrganizationsController < ApplicationController
	before_action :set_organization, only: [:show, :edit, :update]
	before_filter :authenticate_user!
	
  def show
  end
  
  def new
    @organization = Organization.new
  end 

  def create
    @organization = Organization.new(organization_params)
    
    if @organization.save
      @user = current_user
      @user.organization_id = @organization.id
      @user.save
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
