class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def change
    change_column :clients, :postal_code, :string, null: true
    change_column :clients, :address, :string, null: true
  end
end
