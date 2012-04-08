class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :get_auth_from_env
  
  skip_before_filter :verify_authenticity_token
  
  
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
    

    def after_omniauth_failure_path_for(resource)
      root_path
    end
    
end
