class OrdersController < ApplicationController
  def update
    @order = current_order
    if @order.update(order_params)
      redirect_to charges_address_path
    else
      render :back
      flash[:notice] = "Something is amuck."
    end
  end

  def edit
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def mark_as_placed
    @order = Order.find(params[:id])
    if @order.update_attributes(order_status_id: 2)
      flash[:notice] = "The order status has been changed."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Hmmm...something went wrong."
    end
  end

  def mark_as_shipped
    @order = Order.find(params[:id])
    if @order.update_attributes(order_status_id: 3)
      OrderMailer.order_shipped(@order.user, @order).deliver_now
      flash[:notice] = "The customer has been notified that their order shipped!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Hmmm...something went wrong."
    end
  end

  def mark_as_cancelled
    @order = Order.find(params[:id])
    if @order.update_attributes(order_status_id: 4)
      flash[:notice] = "That order has been successfully deleted!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Hmmm...something went wrong."
    end
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :tax, :shipping, :total, :order_status_id, :user_id, :date_placed, :shipping_choice)
  end
end
