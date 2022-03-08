class CreatePriceScales < ActiveRecord::Migration[6.0]
  def change
    create_table :price_scales do |t|
      t.string  :title,             null: false
      t.string  :surface_treatment, null: false
      t.integer :scale_w_0_3
      t.integer :scale_w_3_6
      t.integer :scale_w_6_11
      t.integer :scale_w_11_15
      t.integer :scale_w_15_22
      t.integer :scale_w_22_30
      t.integer :scale_w_30_50
      t.integer :scale_w_50_80
      t.integer :scale_w_80_150
      t.integer :scale_w_150_180
      t.integer :scale_w_180over
      t.integer :scale_a_0_3
      t.integer :scale_a_3_6
      t.integer :scale_a_6_11
      t.integer :scale_a_11_15
      t.integer :scale_a_15_22
      t.integer :scale_a_22_30
      t.integer :scale_a_30_50
      t.integer :scale_a_50_80
      t.integer :scale_a_80_150
      t.integer :scale_a_150_180
      t.integer :scale_a_180over
      t.float   :scale_o_0_300
      t.float   :scale_o_300_500
      t.float   :scale_o_500over
      t.integer :min_unit_price
      t.integer :min_total_price

      t.timestamps
    end
  end
end
