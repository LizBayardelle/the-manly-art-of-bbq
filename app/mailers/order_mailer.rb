class OrderMailer < ApplicationMailer
  default from: '"Manly Art of BBQ" <man@manlyartofbbq.com>'

  def order_placed(user, order)
    @user = user
    @order = order

    mail(to: user.email, subject: "Your order has been placed!")
  end

  def new_order(user, order)
    @user = user
    @order = order

    mail(to: "lizbayardelle@gmail.com", subject: "A new order has been placed on MAB.com")
  end

  def order_shipped(user, order)
    @user = user
    @order = order

    mail(to: user.email, subject: "Your MAB order has shipped!")
  end
end
