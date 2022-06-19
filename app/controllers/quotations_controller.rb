class QuotationsController < ApplicationController

  def index
    @type_clients = Client.classification
  end

  def new
    @clients = Client.order(:name_kana)
    @quotation = Quotation.new
  end

  def create
    @clients = Client.order(:name_kana)
    @quotation = Quotation.new(quotation_params)
    if @quotation.save
      redirect_to new_quotation_drawing_path(@quotation.id)
    else
      render :new
    end
  end

  def edit
    @clients = Client.all
    @quotation = Quotation.find(params[:id])
    @drawings = Drawing.where(quotation_id: params[:id])
  end

  def update
    @quotation = Quotation.find(params[:id])
    if @quotation.update(quotation_params)
      if params[:commit] == "図面を追加する"
        redirect_to new_quotation_drawing_path(@quotation.id)
      else
        redirect_to new_quotation_path, notice: '見積を保存しました(承認待ち)'
      end
    else
      render :edit
    end
  end

  def destroy
    quotation = Quotation.find(params[:id])
    quotation.destroy
    redirect_to index_quotations_client_path(quotation.client_id), notice: '見積を削除しました'
  end

  private

  def quotation_params
    params.require(:quotation)
          .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                  :delivery_place, :business_terms, :total_price, :remarks, :hidden_remarks, :appro_user_id, :approval, :printing)
          .merge(mk_user_id: current_user.id)
  end

  
end
