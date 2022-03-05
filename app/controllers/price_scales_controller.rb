class PriceScalesController < ApplicationController
  before_action :set_price_scale, only: [:edit, :update]

  def index
    @price_scales = PriceScale.all
  end

  def new
    @price_scale = PriceScale.new
  end

  def create
    @price_scale = PriceScale.new(price_scale_params)
    if @price_scale.save
      redirect_to price_scales_path, notice: '単価表を登録しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @price_scale.update(price_scale_params)
      redirect_to price_scales_path, notice: '単価表を編集しました'
    else
      render :edit
    end
  end
  
  def destroy
    price_scale = PriceScale.find(params[:id])
    price_scale.destroy
    redirect_to price_scales_path, notice: '単価表を削除しました'
  end

  private
  
  def price_scale_params
    params.require(:price_scale)
          .permit(:title, :surface_treatment, :scale_w_0_3, :scale_w_3_6, :scale_w_6_10,
                  :scale_w_10_15, :scale_w_15_22, :scale_w_22_30, :scale_w_30_40,
                  :scale_w_40_55, :scale_w_55_75, :scale_w_75_100, :scale_w_100over,
                  :scale_a_0_3, :scale_a_3_6, :scale_a_6_10, :scale_a_10_15, :scale_a_15_22,
                  :scale_a_22_30, :scale_a_30_40, :scale_a_40_55, :scale_a_55_75,
                  :scale_a_75_100, :scale_a_100over, :scale_o_0_300, :scale_o_300_500,
                  :scale_o_500over)
  end

  def set_price_scale
    @price_scale = PriceScale.find(params[:id])
  end

end
