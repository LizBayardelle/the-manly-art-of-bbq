class AddSizeToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :size, :string, default: "Not Applicable"
  end
end
