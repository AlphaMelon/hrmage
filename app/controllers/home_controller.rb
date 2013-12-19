class HomeController < ApplicationController
  def index
    if !account_signed_in?
      render layout: "marketing"
    end
  end
  
  def my_leaves
    @pending_leaves = current_account.profile.leaves.where(status: "Pending")
    @approved_leaves = current_account.profile.leaves.where(status: "Approved")
    @rejected_leaves = current_account.profile.leaves.where(status: "Rejected")
  end
end
