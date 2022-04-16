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
    if @quotation.update(quotation_params)
      redirect_to quotations_path
    else
      render :edit
    end
  end

  private

  def quotation_params
    if params[:approval_btn]
      params.require(:quotation)
            .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                    :delivery_place, :business_terms, :total_price, :remarks)
            .merge(appro_user_id: current_user.id, approval: 1)
    else
      params.require(:quotation)
            .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                    :delivery_place, :business_terms, :total_price, :remarks)
            .merge(appro_user_id: current_user.id, approval: 2)
    end
  end

end
