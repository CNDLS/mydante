class ApplicationController < ActionController::Base
  
  # security
  protect_from_forgery
  
  # authentication
  # before_filter :authenticate_user!
  
  # ui
  helper :ui
  
end
