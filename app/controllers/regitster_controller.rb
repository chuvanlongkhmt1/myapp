class RegitsterController < ApplicationController
  skip_before_action :authorized, only: [:create]
  def create
    user = User.create!(user_params)
    render json: {
      user: user.as_json(only: %i[id name email]),
      message: "sign up succes, sign in to use!",
      redirect: '/signin',
    }
  end

  private

  def user_params
    params.permit(:id, :name,  :email, :password,)
  end
end
