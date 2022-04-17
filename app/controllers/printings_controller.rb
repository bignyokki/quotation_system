class PrintingsController < ApplicationController

  def index
    @quotations = Quotation.where(approval: 1, printing: 0)
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
end
