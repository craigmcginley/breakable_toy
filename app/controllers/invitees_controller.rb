class InviteesController < ApplicationController
  before_filter :authorized_for_admin_tools

  def index
    @family = Family.find(params[:family_id])
    @invitees = @family.invitees
    @invitee = Invitee.new
  end

  def create
    @family = Family.find(params[:family_id])
    @invitee = Invitee.new(invitee_params)
    @invitee.status = "pending"
    @invitee.family = @family

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

  def destroy
    Invitee.destroy(params[:id])
    flash[:notice] = "Successfully removed invitation."
    redirect_to family_invitees_path
  end

  private

  def invitee_params
    params.require(:invitee).permit(:name, :email)
  end
end
