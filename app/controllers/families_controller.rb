class FamiliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_family, only: [:show, :edit, :update, :destroy]
  before_filter :authorized_for_admin_tools, only: [:edit, :update, :destroy]

  def index
    @families = current_user.families
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @family.family_members.build(family: @family, user: current_user, role: "admin")

    if @family.save
      flash[:notice] = "Created your family!"
      redirect_to families_path
    else
      flash.now[:notice] = "Please check the requirements."
      render :new
    end
  end

  def update
    if @family.update(family_params)
      flash[:notice] = "Successfully updated."
      redirect_to families_path
    else
      flash.now[:notice] = "Please check the requirements."
      render :edit
    end
  end

  def destroy
    @family.destroy
    flash[:notice] = "Family deleted."
    redirect_to families_path
  end

  private

  def family_params
    params.require(:family).permit(:surname)
  end

  def set_family
    @family = Family.find(params[:id])
  end
end
