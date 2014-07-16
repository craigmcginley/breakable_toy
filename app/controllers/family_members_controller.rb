class FamilyMembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_family
  before_filter :authorized_for_admin_tools

  def update
    @member.role = "admin"
    @member.save
    flash[:notice] = "Family member promoted!"
    redirect_to family_invitees_path(@family)
  end

  def destroy
    invite = Invitee.find_by(email: @member.user.email, family: @family)
    invite.destroy
    @member.destroy
    flash[:notice] = "Family member removed."
    redirect_to family_invitees_path(@family)
  end

  private

  def set_family
    @member = FamilyMember.find(params[:id])
    @family = @member.family
  end

end
