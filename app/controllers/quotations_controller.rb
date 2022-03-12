class QuotationsController < ApplicationController

  def index
    @quotations = Quotation.all
  end

  def new
    @clients = Client.all
    @price_scales = PriceScale.all
    @quotation = Quotation.new
  end

  def create
    @quotation = Quotation.new(quotation_params)
    if @quotation.save
      redirect_to quotations_path
    else
      render :new
    end
  end


  def create_drawing
    Drawing.create(drawing_params)
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def quotation_params
    params.require(:quotation)
          .permit(:client_id, :title, :charge, :delivery_date, :expiration_date,
                  :delivery_place, :business_terms, :total_price, :remarks)
          .merge(user_id: current_user.id)
  end

  
end
