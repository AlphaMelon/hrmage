class PositionsController < ApplicationController
	before_action :set_organization
	before_action :set_position, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  load_and_authorize_resource
  
  def index
    @positions = current_organization.positions
  end
  
  def new
    @position = current_organization.positions.new
  end 

  def create
    @position = current_organization.positions.new(position_params)
    if @position.save
      redirect_to organization_positions_path(current_organization), notice: "Position successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @position.update(position_params)
			redirect_to organization_positions_path(current_organization), notice: 'Position successfully updated'
		else
			render action: 'edit'
		end
  end

	def destroy
		@position.destroy
		redirect_to organization_positions_path, notice: 'Position successfully deleted'
	end

  private
	
	def set_position
	  @position = Position.find(params[:id])
	end

	def set_organization
	  @organization = Organization.find(params[:organization_id])
	end

	def position_params
		params.require(:position).permit(:name, :max_leaves_seconds, :organization_id, :properties, 
		:can_approve_leave, :can_approve_claim, :monthly_max_claims_cents, :monthly_max_claims)
	end
end
