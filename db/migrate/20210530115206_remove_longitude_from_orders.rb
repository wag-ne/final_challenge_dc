class RemoveLongitudeFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :longitude, :decimal
  end
end
