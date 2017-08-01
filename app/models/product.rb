class Product < ActiveRecord::Base
  has_many :order_items
  has_attached_file :product_image
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/
validates_attachment_file_name :product_image, matches: [/png\z/, /jpe?g\z/]

  default_scope { where(active: true) }
end
