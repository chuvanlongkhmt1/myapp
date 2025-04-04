class SessionsController < ApplicationController
  skip_before_action :authorized
  
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
      render json: { token: token, message: 'success!', redirect: '/',}
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def profile
    header = request.headers['Authorization']
    token = header
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      user = User.find(decoded["user_id"])
      render json: { user: user.as_json(only: %i[id name email ]).merge({avatar_url: user.avatar_url}), }
    rescue
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
