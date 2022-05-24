class PrintingsController < ApplicationController

  def index
    # 承認済み(approval:1)で印刷していない(printing:0)の見積もりを呼び出す
    @quotations = Quotation.where(approval: 1, printing: 0).includes(:drawings)
  end

  def show
    @quotation = Quotation.includes(:drawings).find(params[:id])
    @mk_user = User.find(@quotation.mk_user_id)
    @appro_user = User.find(@quotation.appro_user_id)
    # 印刷済に更新する
    @quotation.update(printing: 1)
  end

end
