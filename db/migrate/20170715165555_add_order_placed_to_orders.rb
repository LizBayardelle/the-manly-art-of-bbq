class AddOrderPlacedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :date_placed, :datetime
  end
end
