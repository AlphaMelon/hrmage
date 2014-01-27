class UserMailer < ActionMailer::Base
  default from: "admin@melon.officemage.dev"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def apply_claim(account_id, claim_id)
    @account = Account.find(account_id)
    @claim = Claim.find(claim_id)
    mail to: @account.email, subject: "Claim need approval"    
  end

  def claim_approval(account_id, claim_id)
    @account = Account.find(account_id)
    @claim = Claim.find(claim_id)
    mail to: @account.email, subject: "Your claim has been approved"    
  end

  def apply_leave(account_id, leave_id)
    @account = Account.find(account_id)
    @leave = Leave.find(leave_id)
    mail to: @account.email, subject: "Leave need approval"    
  end

  def leave_approval(account_id, leave_id)
    @account = Account.find(account_id)
    @leave = Leave.find(leave_id)
    mail to: @account.email, subject: "Your leave has been approved"    
  end

end
