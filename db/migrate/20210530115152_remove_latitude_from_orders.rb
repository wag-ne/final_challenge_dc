class RemoveLatitudeFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :latitude, :decimal
  end
end
