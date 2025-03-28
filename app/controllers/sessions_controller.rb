class SessionsController < ApplicationController
  # skip_before_action :authorized, only: [:signin]
  # def signin
  #   user = User.find_by(email: params[:email])
  #   if user&&user.authenticate(params[:password])
  #     session[:user_id] = user.id

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

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      token = JWT.encode(payload, Rails.application.secrets.secret_key_base)

      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def profile
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      user = User.find(decoded["user_id"])
      render json: { user: user }
    rescue
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
