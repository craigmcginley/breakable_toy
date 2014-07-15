class FamilyMembersController < ApplicationController

  def update
    member = FamilyMember.find(params[:id])
    member.role = "admin"
    member.save
    flash[:notice] = "Family member promoted!"
    redirect_to family_invitees_path(member.family)
  end

  def destroy
    member = FamilyMember.find(params[:id])
    family = member.family
    member.destroy
    flash[:notice] = "Family member removed."
    redirect_to family_invitees_path(family)
  end

end
