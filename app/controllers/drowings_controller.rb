class DrowingsController < ApplicationController
  def create
  end

  private

  def drawing_params
    params.require(:drawing)
          .premit(:figure_number, :product_name, :metarial, :size, :surface_treatment,
                  :price_scale_id, :quantity, :price, :notes)
  end
end
