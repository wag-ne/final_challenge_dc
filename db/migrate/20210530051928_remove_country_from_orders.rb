class RemoveCountryFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :country, :string
  end
end
