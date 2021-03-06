class MenusController < ApplicationController

  def index

    # 最新の見積２０件を取得
    @quotations = Quotation.where(approval: 1).order("created_at DESC").limit(20).includes(:drawings)

    # 承認待ち、印刷待ちの件数を取得（１００件以上の時は99+と表示)
    @appro_count = Quotation.where(approval: 0).count
      @appro_count = "99+" if @appro_count > 99
    @appro_not_count = Quotation.where(approval: 2).count
      @appro_not_count = "99+" if @appro_not_count > 99
    @print_count = Quotation.where(approval: 1, printing: 0).count
      @print_count = "99+" if @print_count > 99

  end

end
