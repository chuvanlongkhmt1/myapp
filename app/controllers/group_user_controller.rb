class GroupUserController < ApplicationController
  #skip_before_action :authorized, only: [:index]
  def index
    groupuser = GroupUser.all
    render json: groupuser
  end
    
  def show
    groupuser = GroupUser.find(params["id"])
    user = User.where("group_user_id = ?", params[:id])
    render json: {user: user, groupuser: groupuser} 
  end

  def create
    groupuser = GroupUser.create!(groupuser_params)
      render json: {message: 'success'}
  end

  def update
    groupuser = GroupUser.find(params["id"])
    groupuser.update!(groupuser_params)
      render json: {message: 'success'}
  end

  def destroy
    GroupUser.find(params["id"]).destroy!
      render json: {message: 'success'}
  end

  private

  def groupuser_params
    params.permit(:id, :name,)
  end
end
