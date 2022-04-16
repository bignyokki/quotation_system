class CreateQuotations < ActiveRecord::Migration[6.0]
  def change
    create_table :quotations do |t|
      t.string     :title,          null: false
      t.string     :charge
      t.string     :delivery_date
      t.string     :expiration_date
      t.string     :delivery_place
      t.string     :business_terms
      t.integer    :total_price
      t.text       :remarks
      t.text       :hidden_remarks
      t.integer    :approval
      t.integer    :printing
      t.references :mk_user
      t.references :appro_user
      t.references :client,         null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :quotations, :users, column: :mk_user_id
    add_foreign_key :quotations, :users, column: :appro_user_id
  end
end
