class AfterSignupController < ApplicationController
  include Wicked::Wizard

  steps :about_yourself, :create_organization, :add_department, :add_staff
  
  def show

    case step
    when :about_yourself
      @employee = current_user.build_employee
    when :create_organization
      @organization = Organization.new
    when :add_department
      @department = Department.new
    when :add_staff
      @employee = Employee.new
    end
    render_wizard
    
  end
  
  def update
    
    case step
    when :about_yourself
      @employee = current_user.build_employee
      emp_params = params.require(:employee).permit(:last_name, :first_name, :mobile_contact, :address, :photo)
      @employee.update_attributes(emp_params)
      @employee.save
      #redirect_to wizard_path(:create_organization)
      redirect_to "/after_signup/create_organization", notice: "Details saved!"
      
    when :create_organization
      @organization = Organization.new
      organization_params = params.require(:organization).permit(:name, :domain)
      @organization.update_attributes(organization_params)
      @organization.save
      
      @user = current_user
      @user.organization_id = @organization.id
      @user.save
      
      redirect_to "/after_signup/add_department", notice: "Organization saved!"
    when :add_department
      departments = []
      departments << params[:department_1]
      departments << params[:department_2]
      departments << params[:department_3]
      departments << params[:department_4]
      departments << params[:department_5]
      departments = departments.reject(&:empty?)
      
      departments.each do |department|
        dep = Department.new
        dep.name = department
        dep.organization_id = current_user.organization.id
        dep.save
      end

      redirect_to "/after_signup/add_staff", notice: "Department saved!"
    when :add_staff
      user = User.where(email: params[:email]).first_or_initialize
      user.password = params[:password]
      user.role = params[:role]
      user.organization_id = current_user.organization_id
      user.save
      
		  employee_params = params.require(:employee).permit(:first_name, :last_name, :mobile_contact, 
		  :address, :photo, :properties, :department_ids)
      @employee = Employee.new(employee_params)
      @employee.user = user
      @employee.save

      #redirect_to finish_wizard, notice: "Staff saved!"
      redirect_to organization_path(current_user.organization), notice: "Congratulation! Have a look at your Organization!"
    end
    
    

  end
  
private

  def finish_wizard
    redirect_to organization_path(current_user.organization), notice: "Congratulation! Have a look at your Organization!"
  end
  
end
