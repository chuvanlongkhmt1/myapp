class GroupUserController < ApplicationController
  # skip_before_action :authorized, only: [:index]
  def index
    groupuser = GroupUser.all
    render json: groupuser
  end
    
  def show
    user = User.where("group_user_id = ?", params[:id])
    render json: user 
  end

  def create
    groupuser = GroupUser.create(groupuser_params)
    if groupuser.save
      render json: GroupUser.all
    else
      render json: errors(groupuser), status: 422
    end
  end

  def update
    groupuser = GroupUser.find(params["id"])
    if groupuser.update(groupuser_params)
      render json: GroupUser.all
    else
      render json: errors(groupuser), status: 422
    end
  end

  def destroy
    if GroupUser.find(params["id"]).destroy!
      render json: GroupUser.all
    else
      render json: errors(groupuser), status: 422
    end
  end

  private

  def groupuser_params
    params.require(:group_user).permit(:id, :name,)
  end
end
