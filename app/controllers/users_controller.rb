class UsersController < ApplicationController
  skip_before_action :authorized
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
    render json: {
      user: User.all,
      message: 'success!',
    }
  end

  def update
    user = User.find(params["id"])
    user.update!(user_params)
      render json: {
        user: User.all,
        message: 'success',
      }
  end

  def destroy
    User.find(params["id"]).destroy!
    render json: {
      user: User.all,
      message: 'delete success',
    }
  end

  private

  def user_params
    params.permit(:id, :name, :age, :group_user_id, :email, :password, :avatar)
  end
end
