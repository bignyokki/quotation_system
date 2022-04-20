class ApprovalsController < ApplicationController

  def index
    @quotations = Quotation.where(approval: 0)
  end

  def edit
    @clients = Client.all
    @quotation = Quotation.find(params[:id])
    @drawings = Drawing.where(quotation_id: params[:id])
  end

  def update
    @quotation = Quotation.find(params[:id])
    # 押されたボタンによって承認状況を更新（承認:1, 差し戻し:2)
    @quotation.updata(approval: 1) if params[:approval_btn]
    @quotation.updata(approval: 2) if params[:back_btn]
    if @quotation.update(quotation_params)
      redirect_to quotations_path
    else
      render :edit
    end
  end

  private

  def quotation_params
      params.require(:quotation)
            .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                    :delivery_place, :business_terms, :total_price, :remarks)
            .merge(appro_user_id: current_user.id)
    end
  end

end
