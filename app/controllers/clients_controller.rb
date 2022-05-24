class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update]


  def index
    @type_clients = Client.classification
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
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
    @quotations = Quotation.where(client_id: params[:id]).includes(:drawings)
  end

  private
  def client_params
    params.require(:client)
          .permit(:name, :name_kana, :phone_number, :fax_number,
                  :email, :postal_code, :address, :person,
                  :remarks, :value_class)
  end

  def set_client
    @client = Client.find(params[:id])
  end


end
