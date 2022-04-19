class PrintingsController < ApplicationController

  def index
    # 承認済み(approval:1)で印刷していない(printing:0)の見積もりを呼び出す
    @quotations = Quotation.where(approval: 1, printing: 0)
  end

  def edit
    @clients = Client.all
    @quotation = Quotation.find(params[:id])
    @drawings = Drawing.where(quotation_id: params[:id])
  end

  def update
    @quotation = Quotation.find(params[:id])
    if @quotation.update(printing_params)
      redirect_to printing_path(params[:id])
    else
      render :index
    end
  end

  def show
    @clients = Client.all
    @quotation = Quotation.find(params[:id])
    @drawings = Drawing.where(quotation_id: params[:id])
  end

  private

  def printing_params
    params.require(:quotation)
            .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                    :delivery_place, :business_terms, :total_price, :remarks, :printing)
            .merge(appro_user_id: current_user.id)
  end
end
