class RemoveValueclassFromClients < ActiveRecord::Migration[6.0]
  def change
    remove_column :clients, :value_class, :string
  end
end
