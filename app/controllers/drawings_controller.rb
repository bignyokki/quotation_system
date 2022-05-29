class DrawingsController < ApplicationController

  def index
    @drawings = Drawing.order("created_at DESC")
  end

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

  def edit
    @drawing = Drawing.find(params[:id])
    @quotation = Quotation.find(@drawing.quotation_id)
    @price_scales = PriceScale.all
  end

  def update
    @drawing = Drawing.find(params[:id])
    if @drawing.update(drawing_params)
      redirect_to edit_quotation_path(@drawing.quotation_id), notice: '図面を編集しました'
    else
      render :edit
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
