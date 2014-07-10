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

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
