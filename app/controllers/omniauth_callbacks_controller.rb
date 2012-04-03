class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :get_auth_from_env
  
  def ldap
    @user = User.find_or_create_from_ldap(@auth)
    sign_in_and_redirect(:user, @user)
  end
  
  
  def shibboleth
    @user = User.find_or_create_from_shibboleth(@auth)
    sign_in_and_redirect(:user, @user)
  end
  
  
  protected
  
    def get_auth_from_env
      @auth = env["omniauth.auth"]
    end
    
end
