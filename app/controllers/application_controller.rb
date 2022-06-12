class ApplicationController < ActionController::Base
  # Basic認証
  # before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログインしていなければログイン画面に遷移する
  before_action :authenticate_user! 

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: '画面を閲覧する権限がありません。'
  end


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数を読み込み
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number, :name, :admin_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:employee_number])
  end

end
