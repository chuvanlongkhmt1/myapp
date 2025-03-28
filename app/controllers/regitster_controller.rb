class RegitsterController < ApplicationController
  def create
    user = User.create!(user_params)
    # session[:user_id] = user.id
    render json: {
      user: user.as_json(only: %i[id name email]),
      message: "success"
    }
  end

  private

  def user_params
    params.permit(:id, :name,  :email, :password,)
  end
end
