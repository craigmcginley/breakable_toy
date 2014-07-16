class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :correct_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :avatar]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :avatar]
  end

  def authorized_for_admin_tools
    @family.family_members.each do |member|
      if member.user == current_user && member.role != "admin"
        not_found
      end
    end
  end

  def correct_user_responding
    invite = Invitee.find(params[:id])
    if current_user.email != invite.email
      not_found
    end
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end
end
