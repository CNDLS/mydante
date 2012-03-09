class UsersController < ApplicationController
  
  def dashboard
    @user = User.find(params[:user_id])
  end
  
  def greet
    @user = User.find(params[:user_id])
    Notifier.greet(@user).deliver
    respond_to do |format|
      flash[:notice] = 'Sent user an email.'
      format.html { redirect_to user_dashboard_path(@user.id) }  
      format.xml  { render :json => @user }
    end
  end
end
