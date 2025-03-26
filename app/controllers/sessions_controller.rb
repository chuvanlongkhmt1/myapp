class SessionsController < ApplicationController
  # skip_before_action :authorized, only: [:signin]
  def signin
    user = User.find_by(email: params[:email])
    if user&&user.authenticate(params[:password])
      session[:current_user_id] = user.id
      render json: {
        logged_in:true,
        user:current_user.as_json(only: %i[id name email ]).merge({avatar_url: user.avatar_url}),
        success:"login success"
        }
    else
      render json:{logged_in:false,
      user:current_user,
      error:"invalid email/password"}
    end
  end
  def destroy
    session[:current_user_id] = nil
  end
end
