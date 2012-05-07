class ApplicationController < ActionController::Base
  
  # security
  protect_from_forgery
  
  # authentication
  # before_filter :authenticate_user!, :except => :index
  
  helper :banner
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_dashboard_path(resource)
  end
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from AbstractController::ActionNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  def render_error exception
    Rails.logger.error(exception)
    render :template => "/errors/500.haml", :status => 500, :locals => { :exception => exception }
  end

  def render_not_found exception
    Rails.logger.error(exception)
    render :template => "/errors/404.haml", :status => 404
  end
  
end
