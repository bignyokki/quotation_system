class DrawingsController < ApplicationController
  def new
    @drawing = Drawing.new
    @quotation = Quotation.find(params[:quotation_id])
    @price_scales = PriceScale.all
  end
  
  def create
    @drawing = Drawing.new(drawing_params)
    if @drawing.save
      render json:{ post: @drawing }
    else
      render :new
    end
  end

  private
  def drawing_params
    params.require(:drawing)
          .permit(:figure_number, :product_name, :material, :surface_treatment, :weight, :area, :size,
                  :price, :quantity, :notes)
          .merge(quotation_id: params[:quotation_id])
  end
  
end
