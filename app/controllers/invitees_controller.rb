class InviteesController < ApplicationController

  def index
    @family = Family.find(params[:family_id])
    @invitees = @family.invitees
    @invitee = Invitee.new
  end

  def show
    @invites = Invitee.where(email: current_user.email)
  end

  def create
    @family = Family.find(params[:family_id])
    @invitee = Invitee.new(invitee_params)
    @invitee.status = "pending"
    @invitee.family = @family
    @users_invitees = Invitee.where(email: @invitee.email)

    @users_invitees.each do |invite|
      if invite.family == @invitee.family
        flash[:notice] = "That person has already been invited to this family."
        redirect_to family_invitees_path(@invitee.family) and return
      end
    end

    if @invitee.save
      Invites.invite(@invitee, current_user).deliver
      flash[:notice] = "Successfully Invited!"
      redirect_to family_invitees_path(@family)
    else
      @invitees = @family.invitees
      flash.now[:notice] = "Please check the requirements."
      render :index
    end
  end

  def update
    @invitee = Invitee.find(params[:id])
    @invitee.user = current_user
    @invitee.status = "joined"
    @invitee.make_family_member

    if @invitee.save
      flash[:notice] = "Accepted invitation!"
      redirect_to invitee_path(current_user.id)
    else
      flash[:notice] = "Something went wrong."
      redirect_to invitee_path(current_user.id)
    end
  end

  def destroy
    @invitee = Invitee.find(params[:id])

    if @invitee.destroy
      flash[:notice] = "Declined invitation."
      redirect_to invitee_path(current_user.id)
    else
      flash[:notice] = "Something went wrong."
      redirect_to invitee_path(current_user.id)
    end
  end

  private

  def invitee_params
    params.require(:invitee).permit(:name, :email)
  end
end
