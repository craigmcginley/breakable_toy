class UserInviteesController < ApplicationController
  before_filter :correct_user_responding, only: [:update, :destroy]

  def index
    user = User.find(params[:user_id])
    @invites = Invitee.where(email: user.email)
  end

  def update
    @invitee = Invitee.find(params[:id])
    @invitee.user = current_user
    @invitee.status = "joined"
    @invitee.save

    FamilyMember.create(family: @invitee.family, user: current_user)
    post = Post.create(user: current_user, title: "#{current_user.first_name} joined the family")
    FamilyPost.create(family: @invitee.family, post: post.id)

    flash[:notice] = "Accepted invitation!"
    redirect_to user_invitees_path(current_user)
  end

  def destroy
    @invitee = Invitee.find(params[:id])
    @invitee.destroy
    flash[:notice] = "Declined invitation."
    redirect_to user_invitees_path(current_user)
  end
end
