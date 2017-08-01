class AddSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :has_size, :boolean, default: false
    add_column :products, :size_options, :string
  end
end
