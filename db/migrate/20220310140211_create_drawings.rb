class CreateDrawings < ActiveRecord::Migration[6.0]
  def change
    create_table :drawings do |t|
      t.string     :figure_number
      t.string     :product_name
      t.string     :metarial
      t.string     :size
      t.string     :surface_treatment
      t.integer    :quantity
      t.integer    :price
      t.string     :notes
      t.references :price_scale
      t.references :quotation
      t.timestamps
    end
  end
end
