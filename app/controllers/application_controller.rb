class ApplicationController < ActionController::Base
  # before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  # rescue_from ActiveRecord::RecordInvalid, with: :not_create
  protect_from_forgery with: :null_session
  include Errors::ErrorsHandler

  def encode_token(payload)
    JWT.encode(payload, 'hellomars1211') 
  end

  def decoded_token
      header = request.headers['Authorization']
      if header
          token = header.split(" ")[1]
          begin
              JWT.decode(token, 'hellomars1211', true, algorithm: 'HS256')
          rescue JWT::DecodeError
              nil
          end
      end
  end

  def current_user 
      if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
      end
  end

  def authorized
      unless !!current_user
      render json: { message: 'Please log in' }, status: :unauthorized
      end
  end

  private

  # def current_user
  #   puts "ESSSSSSSS #{cookies[:user_id]}"
  #   @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]

  # end

  # def logged_in?
  #   !current_user.nil?  
  # end

  # def authorized
  #   unless logged_in?
  #     # redirect_to '/'
  #     # flash[:error] = "You must be logged in to access this section"
  #   end
  # end

  # def not_create(e)
  #   render json: {
  #     error: e.to_s
  #   }, status: :not_found
  # end

end
