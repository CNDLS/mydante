class UsersController < ApplicationController
  
  def dashboard
    @user = User.find(params[:user_id])
  end
end
