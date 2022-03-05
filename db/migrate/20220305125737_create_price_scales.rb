class CreatePriceScales < ActiveRecord::Migration[6.0]
  def change
    create_table :price_scales do |t|
      t.string  :title,             null: false
      t.string  :surface_treatment, null: false
      t.integer :scale_w_0_3
      t.integer :scale_w_3_6
      t.integer :scale_w_6_10
      t.integer :scale_w_10_15
      t.integer :scale_w_15_22
      t.integer :scale_w_22_30
      t.integer :scale_w_30_40
      t.integer :scale_w_40_55
      t.integer :scale_w_55_75
      t.integer :scale_w_75_100
      t.integer :scale_w_100over
      t.integer :scale_a_0_3
      t.integer :scale_a_3_6
      t.integer :scale_a_6_10
      t.integer :scale_a_10_15
      t.integer :scale_a_15_22
      t.integer :scale_a_22_30
      t.integer :scale_a_30_40
      t.integer :scale_a_40_55
      t.integer :scale_a_55_75
      t.integer :scale_a_75_100
      t.integer :scale_a_100over
      t.float   :scale_o_0_300
      t.float   :scale_o_300_500
      t.float   :scale_o_500over

      t.timestamps
    end
  end
end
