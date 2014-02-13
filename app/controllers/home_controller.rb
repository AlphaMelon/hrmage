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
    @total = @payslip.commission_cents + (current_account.profile.claims.where(status: "Approved", date: @payslip.date.beginning_of_month..@payslip.date.end_of_month).sum :amount_cents)
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
end
