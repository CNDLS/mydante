class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def ldap
    @user = User.find_for_ldap(env["omniauth.auth"], current_user)
    p "@user #{@user.inspect}"
    redirect_to user_dashboard_path(@user)
  end
  
  
  def shibboleth
    @user = User.find_for_shibboleth(env["omniauth.auth"], current_user)
    p "@user #{@user.inspect}"
    redirect_to user_dashboard_path(@user)
  end
end
