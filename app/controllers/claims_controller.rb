class ClaimsController < ApplicationController
	before_action :set_claim, only: [:show, :edit, :update]
	before_action :set_organization
	before_filter :authenticate_account!
	
	load_and_authorize_resource
	

	
  def index
    @pending_claims = @organization.claims.where(status: "Pending").order(id: :desc).page(params[:page]).per(5)
    
    @search = @organization.claims.search(params[:q])
    if params[:q].nil?
      @claims = @organization.claims.order(id: :desc).page(params[:page]).per(5)
    else
      @claims = @search.result.order(id: :desc).page(params[:page]).per(5)
    end
    
    respond_to do |format|
      format.html
      format.csv { send_data @claims.to_csv }
    end
  end
  
  def show
  end
  
  def new
    @claim = @organization.claims.new
  end 

  def create
    @claim = @organization.claims.new(claim_params)
    @claim.employee_id = current_employee.id
    if @claim.save
      @claim.employee.departments.each do |department|
        department.employee_departments.where(leader: true).each do |employee_department|
          UserMailer.apply_claim(employee_department.employee.account, @claim, employee_department.employee.id).deliver if !employee_department.employee.account.nil?
        end
      end
      redirect_to my_claims_path, notice: "Claim successfully applied, please wait for approval"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    @claim.update(action_by_id: current_account.id)
		if claim_params[:status] == "Approved"
		  @claim.approve
		  UserMailer.claim_approval(@claim.employee.account, @claim, @claim.employee).deliver if !@claim.employee.account.nil?
			redirect_to organization_claims_path(current_organization), notice: 'Claim application approved'
		elsif claim_params[:status]  == "Rejected"
		  @claim.reject
		  redirect_to organization_claims_path(current_organization), notice: 'Claim application rejected'
		else
			render action: 'edit'
		end
		
  end
  
	def destroy
		@claim.destroy
		redirect_to organization_claims_path(@organization), notice: 'Claim successfully deleted'
	end
  
  private
  
	def set_claim
		@claim = Claim.find(params[:id])
	end
	
	def set_organization
		@organization = Organization.find(params[:organization_id])
	end
	
	def claim_params
		params.require(:claim).permit(:subject, :date, :amount_cents, :comment, :image, :status, :amount)
	end

end

