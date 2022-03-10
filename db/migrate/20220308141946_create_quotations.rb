class CreateQuotations < ActiveRecord::Migration[6.0]
  def change
    create_table :quotations do |t|
      t.string     :title,          null: false
      t.string     :charge
      t.string     :delivery_date
      t.string     :expiration_date
      t.string     :delivery_place
      t.string     :business_terms
      t.integer    :total_price,    null: false
      t.string     :remarks
      t.references :user,           null: false, foreign_key: true
      t.references :client,         null: false, foreign_key: true

      t.timestamps
    end
  end
end
