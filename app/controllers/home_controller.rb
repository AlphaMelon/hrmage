class HomeController < ApplicationController
  def index
    cookies[:beta] = true if params[:beta]
    if !cookies[:beta]
      render 'coming_soon', layout: 'blank'
      return
    end
    if !account_signed_in?
      render layout: "marketing"
    end
  end
  
  def my_leaves
    authenticate_account!
    @my_leaves = current_account.profile.leaves.all if !current_account.profile.nil?
    @leaves_remaining_percentage = current_account.profile.available_leaves*100/current_account.profile.position.max_leaves if !current_account.profile.position.nil?
    # @pending_leaves = current_account.profile.leaves.where(status: "Pending")
    # @approved_leaves = current_account.profile.leaves.where(status: "Approved")
    # @rejected_leaves = current_account.profile.leaves.where(status: "Rejected")
    # @verification_needed_leaves = current_account.profile.leaves.where(status: "Verification Needed")
  end
  
  def my_claims
    authenticate_account!
    @my_claims = current_account.profile.claims.all
    @claims_remaining_percentage = current_account.profile.available_claims_cents*100/current_account.profile.position.max_claims_cents if !current_account.profile.position.nil?
  end
end
