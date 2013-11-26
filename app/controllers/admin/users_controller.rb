class Admin::UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	before_filter :authenticate_user!
  
  def edit
  end
  
  def update
    if user_params[:password].blank?
      user_param = user_params.except(:password)
    else
      user_param = user_params
    end

		if @user.update(user_param)
			redirect_to admin_employees_path, notice: 'User successfully updated'
		else
			render action: 'edit'
		end
  end
  
  private
  
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :password, :role)
	end
end
