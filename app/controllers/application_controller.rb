class ApplicationController < ActionController::Base
  #before_action :authenticate_user!, except: [:top, :about], unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  private

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
        admin_path
    else
        root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
        new_admin_session_path
    else
        root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end
end