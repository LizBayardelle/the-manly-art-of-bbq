class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def update_order_from_shipping_page(shipping_pair)
    self.shipping = (shipping_pair.split('|')[0].to_f)/100
    self.shipping_choice = shipping_pair.split('|')[1]
    new_total = self.subtotal + self.shipping
    self.update_attributes(total: new_total, shipping_choice: self.shipping_choice)
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
