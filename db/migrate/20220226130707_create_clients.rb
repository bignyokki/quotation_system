class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name,         null: false
      t.string :name_kana,    null: false
      t.string :phone_number, null: false
      t.string :fax_number
      t.string :email
      t.string :postal_code,  null: false
      t.string :address,      null: false
      t.text :person
      t.text :remarks
      t.string :value_class,        null: false

      t.timestamps
    end
  end
end
