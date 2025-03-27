class SessionsController < ApplicationController
  # skip_before_action :authorized, only: [:signin]
  # def signin
  #   user = User.find_by(email: params[:email])
  #   if user&&user.authenticate(params[:password])
  #     cookies[:user_id] = user.id
  #     render json: {
  #       logged_in:true,
  #       user:current_user.as_json(only: %i[id name email ]).merge({avatar_url: user.avatar_url}),
  #       success:"login success"
  #       }
  #   else
  #     render json:{logged_in:false,
  #     user:user,
  #     error:"invalid email/password"}
  #   end
  # end
  # def destroy
  #   session.delete(:user_id)
  #   # current_user = nil
  # end
  def create
    generate_token @current_user
    render json: {message: "Login successfully", success: true, data: @data}, status: 200
  end
  
 def generate_token user
    user.update_attributes login_token: SecureRandom.hex
    access_token = JsonWebToken.encode(user_id: user.id, login_token: user.login_token)
 
    @data = {
      access_token: access_token,
      token_type: "Bearer"
    }
  end
  
  def authenticate
    access_token = request.headers["JWTAuthorization"]
    @decoded = JsonWebToken.decode access_token&.split(" ")&.last
    @current_user = User.find @decoded.try(:[], :user_id)
    return if (@decoded.nil? || @current_user.login_token != @decoded.try(:[], :login_token))
    
    render json: {success: false , data: nil}, status: 400
  end

  def destroy
    @current_user.update_attributes login_token: nil
    render json: {message: "Logout successfully",success: true, data: nil}, status: 200
  end
end
