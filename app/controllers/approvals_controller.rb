class ApprovalsController < ApplicationController
  before_action :editable?, only: [:edit, :update]

  def index
    @quotations = Quotation.where(approval: 0).includes(:drawings)
  end

  def index2
    @quotations = Quotation.where(approval: 2).includes(:drawings)
  end

  def edit
    @clients = Client.all
    @quotation = Quotation.find(params[:id])
    @drawings = Drawing.where(quotation_id: params[:id])
  end

  def update
    @quotation = Quotation.find(params[:id])
    # 押されたボタンによって承認状況を更新（承認:1, 差し戻し:2)
    @quotation.update(approval: 1) if params[:approval_btn]
    @quotation.update(approval: 2) if params[:back_btn]
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

  def editable?
    raise CanCan::AccessDenied unless user_signed_in?

    if params[:id].present? && !current_user_is_admin?
      raise CanCan::AccessDenied
    end
  end

  def current_user_is_admin?
    user_signed_in? && current_user.has_role?(:admin)
  end

end
