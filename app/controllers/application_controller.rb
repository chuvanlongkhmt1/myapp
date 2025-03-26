class ApplicationController < ActionController::Base
  # before_action :authorized
  helper_method :current_user
  # helper_method :sign_in?
  # rescue_from ActiveRecord::RecordInvalid, with: :not_create
  protect_from_forgery with: :null_session
  include Errors::ErrorsHandler

  def current_user
    User.find_by(id: session[:current_user_id])
  end

  # def sign_in?
  #   !current_user.nil?  
  # end

  # def authorized
  #   redirect_to '/' unless logged_in?
  # end

  # private

  # def not_create(e)
  #   render json: {
  #     error: e.to_s
  #   }, status: :not_found
  # end

end
