class PostsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user
      @posts = current_user.visible_posts.order('event_date DESC').distinct
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
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Successfully updated."
      redirect_to post_path(@post)
    else
      flash.now[:notice] = "Please check the requirements."
      render :edit
    end
  end

  def destroy
    @post = Post.find_for_user_or_admin(params[:id], current_user) || not_found
    @post.destroy
    flash[:notice] = "Post deleted."
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :event_date,
      :family_ids => [],
      post_images_attributes: [:title, :url],
      post_videos_attributes: [:title, :set_url])
  end

end
