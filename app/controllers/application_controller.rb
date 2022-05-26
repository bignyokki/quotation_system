class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user! 

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: '画面を閲覧する権限がありません。'
  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number, :name, :admin_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:employee_number])
  end

end
