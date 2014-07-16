class PostsController < ApplicationController

  def index
    if current_user
      @posts = current_user.visible_posts.order('created_at DESC').distinct
    end
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Successfully updated."
      redirect_to post_path(@post)
    else
      flash.now[:notice] = "Please check the requirements."
      render :edit
    end
  end

  def destroy
    Post.destroy(params[:id])
    flash[:notice] = "Post deleted."
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,
      :family_ids => [],
      post_images_attributes: [:title, :url],
      post_videos_attributes: [:title, :set_url])
  end

end
