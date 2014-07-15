class PostImagesController < ApplicationController

  def destroy
    post_image = PostImage.find(params[:id])
    post = post_image.post
    post_image.destroy
    flash[:notice] = "Image deleted."
    redirect_to edit_post_path(post)
  end

end
