class AfterSignupController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_account!
  layout "wizard"
  steps :create_organization, :add_department, :add_position, :add_leave_type, :about_yourself, :payment, :finish
  
  def show
    case step
    when :create_organization
      @organization = Organization.new
    when :add_department
      @department = Department.new
    when :add_position
      @position = Position.new
    when :add_leave_type
      @leave_type = LeaveType.new
    when :about_yourself
      @employee = current_account.build_profile
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
      organization_params = params.require(:organization).permit(:name, :default_currency)
      @organization.assign_attributes(organization_params)
      if Rails.env == "development" || Rails.env == "test"
        @organization.domain = (@organization.name.downcase.delete(" ") + ".hrmage.dev")
      elsif Rails.env == "production"
        @organization.domain = (@organization.name.downcase.delete(" ") + ".officemage.com")
      end
      if @organization.save
        account_organization = AccountOrganization.new
        account_organization.organization_id = @organization.id
        account_organization.account_id = current_account.id
        account_organization.role = "Admin"#params[:role]
        account_organization.save
        redirect_to "/after_signup/add_department", notice: "Organization saved!"
      else
        redirect_to "/after_signup/create_organization", notice: "Please fill in the required field"
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
        redirect_to "/after_signup/add_department", notice: "There must be at least one department"
      else
        departments.each do |department|
          dep = Department.new
          dep.name = department
          dep.organization_id = current_account.organizations.first.id
          dep.save
        end
        redirect_to "/after_signup/add_position", notice: "Department saved!"
      end
    when :add_position
      @position = current_account.organizations.first.positions.new
      position_params = params.require(:position).permit(:name, :max_leaves_seconds, :organization_id, :properties, :can_approve_leave, :can_approve_claim, :max_claims_cents, :max_claims)
      @position.assign_attributes(position_params)

      if @position.save
        redirect_to "/after_signup/add_leave_type", notice: "Position saved!"
      else
        redirect_to "/after_signup/add_position", notice: "Please fill in the required field"
      end
    when :add_leave_type
      @leave_type = current_account.organizations.first.leave_types.new
      leave_type_params = params.require(:leave_type).permit(:name, :description, :affected_entity, :type, :approval_needed, :colour)
      @leave_type.assign_attributes(leave_type_params)

      if @leave_type.save
        redirect_to "/after_signup/about_yourself", notice: "Leave type saved!"
      else
        redirect_to "/after_signup/add_leave_type", notice: "Please fill in the required field"
      end
    when :about_yourself
      @employee = current_account.build_profile
      emp_params = params.require(:employee).permit(:last_name, :first_name, :mobile_contact, :address, :photo)
      @employee.assign_attributes(emp_params)
      @employee.organization_id = current_account.organizations.first.id
      if @employee.save
        #redirect_to wizard_path(:create_organization)
        #redirect_to "/after_signup/create_organization", notice: "Details saved!"
        #redirect_to organization_path(current_account.organizations.first), notice: "Congratulation! Have a look at your Organization!"
        redirect_to "/after_signup/payment", notice: "Your profile is created"
      else
        redirect_to "/after_signup/about_yourself", notice: "Please fill in the required field"
      end
    when :payment
    
    end
    
    

  end
  
private

  def finish_wizard
    redirect_to organization_path(current_user.organization), notice: "Congratulation! Have a look at your Organization!"
  end
  
end
