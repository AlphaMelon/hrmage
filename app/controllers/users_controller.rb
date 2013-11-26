class UsersController < ApplicationController
  def show
    @user = current_user
    @employee = current_user.employee
  end
end
