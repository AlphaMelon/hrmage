class PayslipsController < ApplicationController
  before_action :set_employee
  before_filter :authenticate_account!
  
  load_and_authorize_resource
  def index
    @payslips = @employee.payslips
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
    
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def payslip_params
    params.require(:payslip).permit(:employee_id, :organzation_id, :date, :commission, :commission_cents)
  end

end