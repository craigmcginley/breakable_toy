class PostsController < ApplicationController

  def index
    @posts = Post.all.order(:created_at)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.post_images.each do |img|
      img.post = @post
    end
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post created!"
      redirect_to post_path(@post)
    else
      flash.now[:notice] = "Please check the requirements."
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, post_images_attributes: [:title, :url])
  end

end
