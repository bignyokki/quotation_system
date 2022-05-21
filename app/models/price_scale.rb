class PriceScale < ApplicationRecord
  has_many :drawings

  with_options presence: true do
    validates :title
    validates :surface_treatment
    validates :scale_w_0_3,      unless: :scale_a_0_3?
    with_options numericality: true, if: :scale_w_0_3? do
      validates :scale_w_3_6   
      validates :scale_w_6_11
      validates :scale_w_11_15 
      validates :scale_w_15_22 
      validates :scale_w_22_30 
      validates :scale_w_30_50 
      validates :scale_w_50_80 
      validates :scale_w_80_150
      validates :scale_w_150_180
      validates :scale_w_180over
    end
    validates :scale_a_0_3,      unless: :scale_w_0_3?
    with_options numericality: true, if: :scale_a_0_3? do
      validates :scale_a_3_6   
      validates :scale_a_6_11 
      validates :scale_a_11_15 
      validates :scale_a_15_22 
      validates :scale_a_22_30 
      validates :scale_a_30_50 
      validates :scale_a_50_80 
      validates :scale_a_80_150
      validates :scale_a_150_180
      validates :scale_a_180over
    end
    validates :min_unit_price
    validates :min_total_price
  end
  validates :scale_w_0_3, numericality: true, allow_blank: true
  validates :scale_a_0_3, numericality: true, allow_blank: true
end
