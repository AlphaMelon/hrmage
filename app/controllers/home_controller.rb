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
          @leaves_remaining_percentage = 90
          authenticate_account!
          @my_claims = current_account.profile.claims.order(id: :desc)
          @claims_remaining_percentage = current_account.profile.available_claims_cents*100/current_account.profile.position.max_claims_cents
        end
      end
    end
  end
  
  def my_leaves
    authenticate_account!
    @my_leaves = current_account.profile.leaves.order(id: :desc) if !current_account.profile.nil?
    @leaves_remaining_percentage = 90
  end
  
  def my_claims
    authenticate_account!
    @my_claims = current_account.profile.claims.order(id: :desc) if !current_account.profile.nil?
    @claims_remaining_percentage = current_account.profile.available_claims_cents*100/current_account.profile.position.max_claims_cents if !current_account.profile.position.nil?
  end

  def my_salary
    authenticate_account!
    @payslips = current_account.profile.payslips.order(id: :desc) if !current_account.profile.nil?
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
