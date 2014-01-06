class HomeController < ApplicationController
  def index
    if !account_signed_in?
      render layout: "marketing"
    end
    params[:beta] = session[:beta] if session[:beta]
      if !params[:beta]
        session[:beta] = false
        render 'coming_soon',layout: 'blank'
        return
      end
  end
  
  def my_leaves
    authenticate_account!
    @my_leaves = current_account.profile.leaves.all
    @leaves_remaining_percentage = current_account.profile.available_leaves*100/current_account.profile.position.max_leaves
    # @pending_leaves = current_account.profile.leaves.where(status: "Pending")
    # @approved_leaves = current_account.profile.leaves.where(status: "Approved")
    # @rejected_leaves = current_account.profile.leaves.where(status: "Rejected")
    # @verification_needed_leaves = current_account.profile.leaves.where(status: "Verification Needed")
  end
end
