class PriceScalesController < ApplicationController
  before_action :set_price_scale, only: [:edit, :update]
  before_action :creatable?, only: [:new, :create]
  before_action :editable?, only: [:edit, :update]
  before_action :destructible?, only: :destroy

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
          .permit(:title, :surface_treatment, :scale_w_0_3, :scale_w_3_6, :scale_w_6_11,
                  :scale_w_11_15, :scale_w_15_22, :scale_w_22_30, :scale_w_30_50,
                  :scale_w_50_80, :scale_w_80_150, :scale_w_150_180, :scale_w_180over,
                  :scale_a_0_3, :scale_a_3_6, :scale_a_6_11, :scale_a_11_15, :scale_a_15_22,
                  :scale_a_22_30, :scale_a_30_50, :scale_a_50_80, :scale_a_80_150,
                  :scale_a_150_180, :scale_a_180over, :scale_o_0_300, :scale_o_300_500,
                  :scale_o_500over, :min_unit_price, :min_total_price)
  end

  def set_price_scale
    @price_scale = PriceScale.find(params[:id])
  end

  def creatable?
    raise CanCan::AccessDenied unless user_signed_in?

    if !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def editable?
    raise CanCan::AccessDenied unless user_signed_in?

    if params[:id].present? && !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def destructible?
    raise CanCan::AccessDenied unless user_signed_in?

    if params[:id].present? && !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def current_user_is_admin?
    user_signed_in? && current_user.has_role?(:admin)
  end

end
