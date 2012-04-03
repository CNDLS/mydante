class ApplicationController < ActionController::Base
  
  # security
  protect_from_forgery
  
  # authentication
  before_filter :authenticate_user!, :except => :index
  
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_dashboard_path(resource)
  end
  
end
