class PostsController < ApplicationController

  def index
    @posts = Post.all.order(:created_at)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post created!"
      redirect_to root_path
    else
      flash.now[:notice] = "Please check the requirements."
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
