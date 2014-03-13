class AfterSignupController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_account!
  layout "wizard"
  steps :create_organization, :add_department, :add_leave_type, :add_position, :about_yourself, :payment, :finish
  
  def show
    case step
    when :create_organization
      @organization = Organization.new
    when :add_department
      @department = Department.new
    when :add_leave_type
      @leave_type = LeaveType.new
    when :add_position
      @position = Position.new
    when :about_yourself
      @employee = current_account.profiles.new
    when :payment
      
    when :finish
      @organization=current_account.organizations.first
    end
    render_wizard
    
  end
  
  def update
    
    case step
    when :create_organization
      @organization = Organization.new
      organization_params = params.require(:organization).permit(:name, :default_currency, :country)
      @organization.assign_attributes(organization_params)
      if @organization.save
        account_organization = AccountOrganization.new
        account_organization.organization_id = @organization.id
        account_organization.account_id = current_account.id
        account_organization.role = "Super Admin"#params[:role]
        account_organization.save
        redirect_to "/after_signup/add_department", notice: "Organization saved!"
      else
        redirect_to "/after_signup/create_organization", alert: @organization.errors.full_messages.to_sentence
      end
    when :add_department
      departments = []
      departments << params[:department_1]
      departments << params[:department_2]
      departments << params[:department_3]
      departments << params[:department_4]
      departments << params[:department_5]
      departments = departments.reject(&:empty?)
      
      if departments.count == 0
        redirect_to "/after_signup/add_department", alert: "There must be at least one department"
      else
        departments.each do |department|
          dep = Department.new
          dep.name = department
          dep.organization_id = current_account.organizations.first.id
          dep.save
        end
        redirect_to "/after_signup/add_leave_type", notice: "Department saved!"
      end
    when :add_leave_type
      @leave_type = current_account.organizations.first.leave_types.new
      leave_type_params = params.require(:leave_type).permit(:name, :description, :affected_entity, :type, :approval_needed, :colour, :default_count_seconds)
      @leave_type.assign_attributes(leave_type_params)
      @leave_type.default_count_seconds = leave_type_params[:default_count_seconds].to_i*24*60*60 if !leave_type_params[:default_count_seconds].blank?
      if @leave_type.save
        redirect_to "/after_signup/add_position", notice: "Leave type saved!"
      else
        redirect_to "/after_signup/add_leave_type", alert: @leave_type.errors.full_messages.to_sentence
      end
    when :add_position
      @position = current_account.organizations.first.positions.new
      position_params = params.require(:position).permit(:name, :organization_id, :properties, :can_approve_leave, :can_approve_claim, :monthly_max_claims_cents, :monthly_max_claims)
      @position.assign_attributes(position_params)

      if @position.save
        redirect_to "/after_signup/about_yourself", notice: "Position saved!"
      else
        redirect_to "/after_signup/add_position", alert: @position.errors.full_messages.to_sentence
      end
    when :about_yourself
      @employee = current_account.profiles.new
      emp_params = params.require(:employee).permit(:last_name, :first_name, :mobile_contact, :address, :photo, :base_salary_cents, :base_salary,:employee_identification)
      @employee.assign_attributes(emp_params)
      @employee.organization_id = current_account.organizations.first.id
      @employee.position_id = current_account.organizations.first.positions.first.id
      if @employee.save
        #redirect_to wizard_path(:create_organization)
        #redirect_to "/after_signup/create_organization", notice: "Details saved!"
        #redirect_to organization_path(current_account.organizations.first), notice: "Congratulation! Have a look at your Organization!"
        redirect_to "/after_signup/payment", notice: "Your profile is created"
      else
        redirect_to "/after_signup/about_yourself", alert: @employee.errors.full_messages.to_sentence
      end
    when :payment
    
    end
    
    

  end
  
private

  def finish_wizard
    redirect_to organization_path(current_user.organization), notice: "Congratulation! Have a look at your Organization!"
  end
  
end
