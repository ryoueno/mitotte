class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_uuid, :set_projects
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_uuid, if: :devise_controller?, only: [:new]

  private

  def set_uuid
    if params[:uuid].present?
      cookies[:uuid] = params[:uuid]
    end

    if cookies[:uuid].present? && current_user
      current_user.uuid = cookies[:uuid]
      current_user.save!
    end
  end

  def check_uuid
    # if controller_name == 'registrations' and cookies[:uuid].blank?
    #   raise "UUID is required."
    # end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :uuid])
  end

  def set_projects
    current_user.projects = Project.where(:user_id => current_user.id) if current_user
  end
end
