class PostsController < ApplicationController
  skip_before_action :authorized

  def index
    posts = Post.all
    render json: posts
  end

  def show
    post = Post.find(params["id"])
    render json: post
  end

  def create
    post = Post.create!(post_params)
    render json: {
      post: Post.all,
      message: 'success!',
    }
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
      render json: {
      post: Post.all,
      message: 'success',
    }

  end

  def destroy
    Post.find(params["id"]).destroy!
    render json: {
      user: User.all,
      message: 'delete success',
    }
  end
  private

  def post_params
    params.permit(:title, :description)
  end
end