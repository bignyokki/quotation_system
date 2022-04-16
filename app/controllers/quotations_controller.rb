class QuotationsController < ApplicationController

  def index
    @quotations = Quotation.all
  end

  def new
    @clients = Client.all
    @quotation = Quotation.new
  end

  def create
    @clients = Client.all
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
      redirect_to quotations_path
    else
      render :edit
    end
  end

  private

  def quotation_params
    params.require(:quotation)
          .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                  :delivery_place, :business_terms, :total_price, :remarks, :appro_user_id)
          .merge(mk_user_id: current_user.id)
  end

  
end
