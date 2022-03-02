class ClientsController < ApplicationController

  def index
    @clients = Client.all
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

  private
  def client_params
    params.require(:client)
          .permit(:name, :name_kana, :phone_number, :fax_number,
                  :email, :postal_code, :address, :person,
                  :remarks, :value_class)
  end

end
