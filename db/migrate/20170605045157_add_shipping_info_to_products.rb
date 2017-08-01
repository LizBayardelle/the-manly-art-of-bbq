class AddShippingInfoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :weight, :decimal
    add_column :products, :box_length, :decimal
    add_column :products, :box_width, :decimal
    add_column :products, :box_depth, :string
  end
end
