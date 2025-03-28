class ApplicationController < ActionController::Base
  before_action :authorized
  # helper_method :current_user
  # elper_method :logged_in?
  # rescue_from ActiveRecord::RecordInvalid, with: :not_create
  protect_from_forgery with: :null_session
  include Errors::ErrorsHandler

  private

  def current_user
    # token = request.headers['Authorization']
    # decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
    # @current_user = User.find(decoded["user_id"])
  end

  def logged_in?
    !current_user.nil?  
  end

  def authorized
    unless logged_in?
      # redirect_to '/'
      # flash[:error] = "You must be logged in to access this section"
    end
  end

#   def not_create(e)
#     render json: {
#       error: e.to_s
#     }, status: :not_found
#   end

end
