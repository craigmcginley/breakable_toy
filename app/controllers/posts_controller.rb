class PostsController < ApplicationController

  def index
    @posts = current_user.visible_posts.distinct
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @post.post_images.build
    @post.post_videos.build
    @post.families.build
  end

  def create
    @post = current_user.posts.build(post_params)

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
    params.require(:post).permit(:title, :body,
      :family_ids => [],
      post_images_attributes: [:title, :url],
      post_videos_attributes: [:title, :set_url])
  end

end
