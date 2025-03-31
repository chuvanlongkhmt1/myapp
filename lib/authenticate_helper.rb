module AuthenticateHelper
  def authorized
    token=request.headers['Authorization']
    decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0] if(token)
    @current_user = User.find(decoded["user_id"]) if(decoded)
    render json: { error: 'not authenticated', redirect: '/signin', }, status: 401 unless
    @current_user
  end
  def user_sign_in?
    !!current_user
  end
  def current_user
    @current_user
  end
end