class RemoveStateFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :state, :string
  end
end
