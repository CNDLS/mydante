class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def ldap
    @user = User.find_for_ldap_oauth(env["omniauth.auth"], current_user)
    p "@user #{@user.inspect}"
    redirect_to user_dashboard_path(@user)
  end
end
