class PostsController < ApplicationController
  before_action  only: %i[show update destroy]

  def index
    posts = Post.all

    render json: posts
  end

  def show
    post = Post.find(params["id"])
    render json: post
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: 422
    end
  end

  def destroy
    if Post.find(params["id"]).destroy!
      render json: Post.all
    else
      render json: errors(post), status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :profile_picture)
  end
end