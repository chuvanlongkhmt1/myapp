class ApplicationController < ActionController::Base
  # before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  # rescue_from ActiveRecord::RecordInvalid, with: :not_create
  protect_from_forgery with: :null_session
  include Errors::ErrorsHandler

  def current_user
    current_user ||= User.find_by(id: session[:current_user_id]) if session[:current_user_id]
  end

  def logged_in?
    !current_user.nil?  
  end

  # private

  # def not_create(e)
  #   render json: {
  #     error: e.to_s
  #   }, status: :not_found
  # end

end
