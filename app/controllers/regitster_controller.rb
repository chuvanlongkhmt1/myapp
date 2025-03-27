class RegitsterController < ApplicationController
  before_action :authorized
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: {
      user: current_user.as_json(only: %i[id name email])
    }
    head :no_content
  end

  private

  def user_params
    params.permit(:id, :name,  :email, :password,)
  end
end
