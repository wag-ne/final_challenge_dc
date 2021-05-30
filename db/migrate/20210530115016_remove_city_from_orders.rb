class RemoveCityFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :city, :string
  end
end
