class PayslipsController < ApplicationController
  before_action :set_employee
  before_action :set_payslip, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_account!
  load_and_authorize_resource
  
  def index
    @payslips = @employee.payslips.order(date: :asc)
  end

  def new
    @payslip = @employee.payslips.new
  end

  def create
    @payslip = Payslip.new(payslip_params)
    @payslip.employee_id = @employee.id
    @payslip.organization_id = current_organization.id
    if @payslip.save
      redirect_to organization_employee_payslips_path(current_organization, @employee), notice: "Payslips successfully created"
    else
      render action: 'new', alert: "Please fill in the required field"
    end
  end

  def edit
    
  end

  def update
    if @payslip.update(payslip_params)
      redirect_to organization_employee_payslips_path(current_organization, @employee), notice: "Payslips successfully update"
    else
      render action: 'edit'
    end
  end

  def show
    @base_salary_cents = @payslip.base_salary_cents
    @total = 0
    
    if @payslip.include_affected_leave
      @affected_leave = []
      @employee.leaves.where(status: "Approved", start_date: @payslip.leave_start_date..@payslip.leave_end_date).each do |leave|
        if leave.leave_type.affected_entity.include?("salary")
          @affected_leave << leave
        end
      end
      affected_leave_total = 0
      @affected_leave.each do |leave|
        affected_leave_calculation = 0
        if leave.leave_type.type == "LeaveSubstraction"
          affected_leave_calculation =  -(@base_salary_cents/leave.leave_type.divide_by_days*(leave.duration_seconds/working_hours/60/60))
        elsif leave.leave_type.type == "LeaveAddition"
          affected_leave_calculation = @base_salary_cents/leave.leave_type.divide_by_days*(leave.duration_seconds/working_hours/60/60)
        end
        affected_leave_total = affected_leave_total + affected_leave_calculation
      end
      @base_salary_cents = @base_salary_cents + affected_leave_total
    end
    
    
    if @payslip.include_claim
      @claims = @employee.claims.where(status: "Approved", created_at: @payslip.claim_start_date..@payslip.claim_end_date)
    end
    
  end
  
	def destroy
		@payslip.destroy
		redirect_to organization_employee_payslips_path(current_organization, @employee), notice: 'Payslips successfully deleted'
	end
	
  private
  
	def set_payslip
	  @payslip = Payslip.find(params[:id])
	end
	
  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def payslip_params
    params.require(:payslip).permit(:employee_id, :organzation_id, :date, :commission, 
    :commission_cents, :base_salary_cents, :base_salary,:note, 
    :include_claim, :claim_start_date, :claim_end_date, :include_affected_leave,
    :leave_start_date, :leave_end_date, { :payslip_setting_ids => [] })
  end

end
