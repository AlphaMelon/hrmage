class AccountOrganizationsController < ApplicationController
	before_action :set_organization
	before_action :set_account_organization, only: [:destroy]
	before_filter :authenticate_account!
	
  def new
    @account_organization = AccountOrganization.new
  end 

  def create
    @account = Account.where(email: params[:email]).first
    
    @account_organization = AccountOrganization.new(account_organization_params)
    @account_organization.organization_id = @organization.id
    @account_organization.account_id = @account.id if !@account.blank?
    
    if @account_organization.save
      redirect_to organization_path(@organization), notice: "Account linked to #{@organization.name}"
    else
      render action: 'new'
    end
  end
  
  def destroy
    @account_organization.delete
    redirect_to organization_path(@organization), notice: "Account link removed from #{@organization.name}"
  end
  
  private

	def set_organization
		@organization = Organization.find(params[:organization_id])
	end
	
	def set_account_organization
		@account_organization = AccountOrganization.find(params[:id])
	end
	
	def account_organization_params
		params.require(:account_organization).permit(:account_id, :organization_id, :role)
	end
end
