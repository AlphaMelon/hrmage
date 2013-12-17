class LeavesController < ApplicationController
	#before_action :set_employee
	before_action :set_leaves, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_account!
  
  def index
    #@pending_leaves = 
  end
  
  def new
    @leave = current_account.leaves.new
  end 

  def create
    @leave = current_account.leaves.new(leave_params)
    if @leave.save
      redirect_to leaves_path, notice: "Leave successfully created"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @leave.update(leave_params)
			redirect_to leaves_path, notice: 'Leaves status changed'
		else
			render action: 'edit'
		end
  end

	def destroy
		@leave.destroy
		redirect_to leaves_path, notice: 'Leave successfully deleted'
	end

  private
	
	def set_leave
	  @leave = Leave.find(params[:id])
	end

	def document_params
		params.require(:leave).permit(:start_date, :end_date, :comment, :leave_type, :status)
	end
end
