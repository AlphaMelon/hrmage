class AccessLevelsController < ApplicationController
	before_action :set_access_level, only: [:show, :edit, :update]
	before_action :set_organization
	before_action :set_account_organization
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	
  def index
    @access_levels = @account_organization.access_levels.order(id: :asc)
    @employee = Employee.where(account_id: @account_organization.account_id, organization_id: @organization.id).first
  end
  
  def show
  end
  
  def new
    @access_level = @account_organization.access_levels.new
  end 

  def create
    @access_level = @account_organization.access_levels.new(access_level_params)
    
    if @access_level.save
      redirect_to organization_account_organization_access_levels_path(@organization, @account_organization), notice: "Access Level successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @access_level.update(access_level_params)
			redirect_to organization_account_organization_access_levels_path(@organization, @account_organization), notice: "Access Level successfully updated"
		else
			render action: 'edit'
		end
  end
  
	def destroy
	  @access_level.destroy
	  redirect_to organization_account_organization_access_levels_path(@organization, @account_organization), notice: "Access Level successfully deleted"
	end
  
  private
  
	def set_access_level
		@access_level = AccessLevel.find(params[:id])
	end
	
	def set_organization
		@organization = Organization.find(params[:organization_id])
	end

	def set_account_organization
		@account_organization = AccountOrganization.find(params[:account_organization_id])
	end

	def access_level_params
		params.require(:access_level).permit(:account_organization_id, 
		:department_id, :access_level, :class_name)
	end
end
