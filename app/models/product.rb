class Product < ActiveRecord::Base
  has_many :order_items
  has_one_attached :product_image

  default_scope { where(active: true) }
end
