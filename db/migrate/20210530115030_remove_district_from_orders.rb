class RemoveDistrictFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :district, :string
  end
end
