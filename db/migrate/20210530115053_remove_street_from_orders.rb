class RemoveStreetFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :street, :string
  end
end
