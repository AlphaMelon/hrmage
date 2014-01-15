class UserMailer < ActionMailer::Base
  default from: "admin@melon.officemage.dev"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def apply_claim(account, claim)
    @account = account
    @claim = claim
    mail to: account.email, subject: "Claim need approval"    
  end

  def claim_approval(account, claim)
    @account = account
    @claim = claim
    mail to: account.email, subject: "Your claim has been approved"    
  end

  def apply_leave(account, leave)
    @account = account
    @leave = leave
    mail to: account.email, subject: "Leave need approval"    
  end

  def leave_approval(account, leave)
    @account = account
    @leave = leave
    mail to: account.email, subject: "Your leave has been approved"    
  end

end
