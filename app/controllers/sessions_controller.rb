class SessionsController < ApplicationController
  def signin
    user = User.find_by(email: params[:email])
    if user&&user.authenticate(params[:password])
      session[:current_user_id] = user.id
      render json: {
        logged_in:true,
        user:current_user.as_json(only: %i[id name email]),
        success:"login success"
        }
    else
      render json:{logged_in:false,
      user:current_user,
      error:"invalid email/password"}
    end
  end
end
