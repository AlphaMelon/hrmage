class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    after_signup_path(:about_yourself)
  end

end
