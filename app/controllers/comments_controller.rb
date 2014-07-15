class CommentsController < ApplicationController
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
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Comment updated!"
      redirect_to post_path(@comment.post)
    else
      flash.now[:notice] = "Please check the requirements."
      render :edit
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
