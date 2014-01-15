class UserMailer < ActionMailer::Base
  default from: "admin@melon.officemage.dev"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end

  def apply_claim(user)
    @user = user
    mail to: user.email, subject: "Claim need approval"    
  end

  def claim_approval(user)
    @user = user
    mail to: user.email, subject: "Claim Approval"    
  end

  def apply_leave(user)
    @user = user
    mail to: user.email, subject: "Leave need approval"    
  end

  def leave_approval(user)
    @user = user
    mail to: user.email, subject: "Leave Approval"    
  end

end
