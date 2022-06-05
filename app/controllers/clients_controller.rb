class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update]
  before_action :creatable?, only: [:new, :create]
  before_action :editable?, only: :update
  before_action :destructible?, only: :destroy


  def index
    @type_clients = Client.classification
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      # 連続で登録できるよう新規登録ページにリダイレクト
      redirect_to new_client_path, notice: '顧客登録を完了しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: '顧客情報を編集しました'
    else
      render :edit
    end
  end

  def destroy
    client = Client.find(params[:id])
    client.destroy
    redirect_to clients_path, notice: '顧客情報を削除しました'
  end

  def index_quotations
    @client = Client.find(params[:id])
    @quotations = Quotation.where(client_id: params[:id], approval: 1).includes(:drawings)
  end

  private
  def client_params
    params.require(:client)
          .permit(:name, :name_kana, :phone_number, :fax_number,
                  :email, :postal_code, :address, :person, :remarks)
  end

  def set_client
    @client = Client.find(params[:id])
  end

  def creatable?
    raise CanCan::AccessDenied unless user_signed_in?

    if !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def editable?
    raise CanCan::AccessDenied unless user_signed_in?

    if params[:id].present? && !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def destructible?
    raise CanCan::AccessDenied unless user_signed_in?

    if params[:id].present? && !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def current_user_is_admin?
    user_signed_in? && current_user.has_role?(:admin)
  end



end
