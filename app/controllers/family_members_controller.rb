class FamilyMembersController < ApplicationController

  def destroy
    member = FamilyMember.find(params[:id])
    family = member.family
    member.destroy
    flash[:notice] = "Family member removed."
    redirect_to family_invitees_path(family)
  end

end
