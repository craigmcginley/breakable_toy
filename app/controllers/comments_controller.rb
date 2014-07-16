class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:notice] = "Comment added!"
      redirect_to post_path(@comment.post)
    else
      @post = @comment.post
      flash.now[:notice] = "Please check the requirements."
      render :'/posts/show'
    end
  end

  def edit
    # @comment = current_user.editable_comments.find(params[:id])
    correct_user_or_admin(current_user)
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Comment updated!"
      redirect_to post_path(@comment.post)
    else
      flash.now[:notice] = "Please check the requirements."
      render :edit
    end
  end

  def destroy
    @comment = Comment.find_for_user_or_admin(params[:id], current_user) || not_found
    @post = @comment.post
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
