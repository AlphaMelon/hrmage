class PayslipsController < ApplicationController
  before_action :set_employee
  before_action :set_payslip, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_account!
  load_and_authorize_resource
  
  def index
    @payslips = @employee.payslips.order(date: :asc)
  end

  def new
    @payslip = Payslip.new
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
    @affected_leave = []
    @employee.leaves.where(status: "Approved", start_date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).each do |leave|
      if leave.leave_type.affected_entity.include?("salary")
        @affected_leave << leave
      end
    end
    
    @base_salary_cents = @payslip.base_salary_cents
    @total = @payslip.commission_cents + (@employee.claims.where(status: "Approved", created_at: @payslip.date.beginning_of_month..@payslip.date.end_of_month).sum :amount_cents)
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
    :commission_cents, :base_salary_cents, :base_salary, { :payslip_setting_ids => [] })
  end

end
