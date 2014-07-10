class FamiliesController < ApplicationController

  def index
    @families = current_user.families
  end

  def show
    @family = Family.find(params[:id])
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)

    if @family.save
      current_user.families << @family
      flash[:notice] = "Created your Family!"
      redirect_to families_path
    else
      flash.now[:notice] = "Please check the requirements."
      render :new
    end
  end

  private

  def family_params
    params.require(:family).permit(:surname)
  end
end
