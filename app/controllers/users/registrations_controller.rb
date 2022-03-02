# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # サインインしても :new, :createできるようにする
  prepend_before_action :require_no_authentication, only: [:cancel]
  # self.resourceにcurrent_userを入れないよう:editは対象外に
  prepend_before_action :authenticate_scope!, only: [:update, :destroy]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :creatable?, only: [:new, :create]
  before_action :editable?, only: [:edit, :update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    # フォームで入力されたadmin_idによりrorifyの権限を付与
    if @user.admin_id == 1
      @user.add_role :admin
    elsif @user.admin_id == 2
      @user.add_role :editor
    end
  end

  # GET /resource/edit
    def edit
      if by_admin_user?(params)
        self.resource = resource_class.to_adapter.get!(params[:id])
      else
        authenticate_scope!
        super
      end
    end

  # PUT /resource
  def update
    if by_admin_user?(params)
      self.resource = resource_class.to_adapter.get!(params[:id])
    else
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    end

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    if by_admin_user?(params)
      resource_updated = update_resource_without_password(resource, account_update_params)
    else
      resource_updated = update_resource(resource, account_update_params)
    end

    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      if !by_admin_user?(params)
        bypass_sign_in resource, scope: resource_name
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      redirect_to users_index_path
    end
  end

  # DELETE /resource
   def destroy
    binding.pry
     user = User.find(params[:id])
     user.destroy if current_user_is_admin?
     redirect_to users_index_path
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def by_admin_user?(params)
    params[:id].present? && current_user_is_admin?
  end

  # ログインユーザーがadminか判定するメソッド
  def current_user_is_admin?
      user_signed_in? && current_user.has_role?(:admin)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def sign_up(resource_name, resource)
    # adminはサインアップ後自動ログインしないようにする
    if !current_user_is_admin?
      sign_in(resource_name, resource)
    end
  end

  # passwordなしでもpasswordを変更変更できるようにする
  def update_resource_without_password(resource, params)
    resource.update_without_password(params)
  end

  # :createできるか権限をチェック
  def creatable?
    raise CanCan::AccessDenied unless user_signed_in?

    if !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  # :editができるか権限をチェック
  def editable?
    raise CanCan::AccessDenied unless user_signed_in?

    if params[:id].present? && !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end
    
end
