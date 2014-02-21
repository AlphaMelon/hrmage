class HomeController < ApplicationController
  def index
    cookies[:beta] = true if params[:beta]
    if !cookies[:beta]
      render 'coming_soon', layout: 'blank'
      return
    end
    if !account_signed_in?
      if current_organization.id.nil?
        render layout: "marketing"
      else
        redirect_to new_account_session_path
      end
    end

    if account_signed_in?
      if !current_account.profile.nil?
        if !current_account.profile.position.nil?
          @my_leaves = current_account.profile.leaves.order(id: :desc)
          authenticate_account!
          @my_claims = current_account.profile.claims.order(id: :desc)
          @claims_remaining_percentage = (current_account.profile.claims.where(status: "Approved", date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).sum :amount_cents)/current_account.profile.position.monthly_max_claims_cents
        end
      end
    end
  end
  
  def my_leaves
    authenticate_account!
    @my_leaves = current_account.profile.leaves.order(id: :desc) if !current_account.profile.nil?
  end
  
  def my_claims
    authenticate_account!
    @my_claims = current_account.profile.claims.order(id: :desc) if !current_account.profile.nil?
    @claims_remaining_percentage = (current_account.profile.claims.where(status: "Approved", date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).sum :amount_cents)/current_account.profile.position.monthly_max_claims_cents
  end

  def my_salary
    authenticate_account!
    @my_salarys = current_account.profile.payslips.order(date: :asc) if !current_account.profile.nil?
  end

  def my_salary_show
    @payslip = Payslip.find(params[:payslip_id])
    @affected_leave = []
    current_account.profile.leaves.where(status: "Approved", start_date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).each do |leave|
      if leave.leave_type.affected_entity.include?("salary")
        @affected_leave << leave
      end
    end
    
    @base_salary_cents = @payslip.base_salary_cents
    @total = @payslip.commission_cents + (current_account.profile.claims.where(status: "Approved", created_at: @payslip.date.beginning_of_month..@payslip.date.end_of_month).sum :amount_cents)
    if @payslip.employee_id != current_account.profile.id
      redirect_to(root_path, alert: "You are not authorize to view this.")
    end
  
  end

  def print_salary
    @payslip = Payslip.find(params[:payslip_id])
    @affected_leave = []
    current_account.profile.leaves.where(status: "Approved", start_date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).each do |leave|
      if leave.leave_type.affected_entity.include?("salary")
        @affected_leave << leave
      end
    end
    @base_salary_cents = @payslip.base_salary_cents
    @total = @payslip.commission_cents + (current_account.profile.claims.where(status: "Approved", created_at: @payslip.date.beginning_of_month..@payslip.date.end_of_month).sum :amount_cents)
    if @payslip.employee_id != current_account.profile.id
      redirect_to(root_path, alert: "You are not authorize to view this.") and return
    end
    render layout: "blank"
  end
  
  def sign_in
    if !account_signed_in?
      render layout: "marketing"
    else
      redirect_to root_path, notice: "You are already signed in."
    end
  end

  def sign_up
    if !account_signed_in?
      render layout: "marketing"
    else
      redirect_to root_path, notice: "You are already signed in."
    end
  end

  def calendar
    
    @my_leaves = "asb"
    @leave_types = current_organization.leave_types
    
    @month = !params[:date].blank? ? params[:date][:month].to_i : DateTime.now.month
    @year = !params[:date].blank? ? params[:date][:year].to_i : DateTime.now.year
    @date = DateTime.new(@year, @month)
    @month_collection = [
    ["January", 1], 
    ["February", 2], 
    ["March", 3], 
    ["April", 4], 
    ["May", 5], 
    ["June", 6], 
    ["July", 7], 
    ["August", 8], 
    ["September", 9], 
    ["October", 10], 
    ["November", 11], 
    ["December", 12]]
    
    @employees = []

    current_account.profile.departments.each do |department| 
      department.employees.each do |employee|
        @employees << employee
      end
    end

    if !current_organization.organization_setting.nil?
      @workday = [false,false,false,false,false,false,false,false]
      @workday[1] = true if !current_organization.organization_setting.monday.blank? && current_organization.organization_setting.monday != 0
      @workday[2] = true if !current_organization.organization_setting.tuesday.blank? && current_organization.organization_setting.tuesday != 0
      @workday[3] = true if !current_organization.organization_setting.wednesday.blank? && current_organization.organization_setting.wednesday != 0
      @workday[4] = true if !current_organization.organization_setting.thursday.blank? && current_organization.organization_setting.thursday != 0
      @workday[5] = true if !current_organization.organization_setting.friday.blank? && current_organization.organization_setting.friday != 0
      @workday[6] = true if !current_organization.organization_setting.saturday.blank? && current_organization.organization_setting.saturday != 0
      @workday[7] = true if !current_organization.organization_setting.sunday.blank? && current_organization.organization_setting.sunday != 0
    end
    
  end
end
