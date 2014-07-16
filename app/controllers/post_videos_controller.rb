class PostVideosController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    post_video = PostVideo.find(params[:id])
    post = post_video.post
    post_video.destroy
    flash[:notice] = "Video removed."
    redirect_to edit_post_path(post)
  end

end
