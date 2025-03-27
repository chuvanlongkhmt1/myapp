class UsersController < ApplicationController

  def index
    users = User.all.map do |user|
      user.as_json.merge({avatar_url: user.avatar_url})
    end
    render json: users 
  end

  def show
    user = User.find(params["id"])
    render json: user
  end

  def create
    user = User.create!(user_params)
    @token = encode_token(user_id: user.id)
    render json: {
      user: User.all,
      token: @token
    }
    head :no_content
  end

  def update
    user = User.find(params["id"])
    if user.update(user_params)
      render json: User.all
    else
      render json: errors(user), status: 422
    end
  end

  def destroy
    if User.find(params["id"]).destroy!
      render json: User.all
    else
      render json: errors(user), status: 422
    end
  end

  private

  def user_params
    params.permit(:id, :name, :age, :group_user_id, :email, :password, :avatar)
  end
end
