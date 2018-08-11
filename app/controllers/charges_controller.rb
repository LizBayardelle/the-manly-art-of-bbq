class ChargesController < ApplicationController
  before_action :authenticate_user!

  def address
    @user = current_user
  end

  def shipping
    @user = current_user
    @products = current_order.order_items.all
    @order = current_order
    @order.update_attributes(user_id: current_user.id)

    packages =  []
    @products.each do |thing|
      packages << ActiveShipping::Package.new( thing.product.weight.to_i * 16,
      [thing.product.box_length.to_i, thing.product.box_width.to_i, thing.product.box_depth.to_i],
      units: :imperial)
    end ## each do

    origin = ActiveShipping::Location.new( country: 'US', state: 'CA', city: 'Newport Coast', zip: '92656')

    if @user.country == 'US'
      destination = ActiveShipping::Location.new( country: @user.country, state: @user.state, city: @user.city, zip: @user.zip)
    else
      destination = ActiveShipping::Location.new( country: @user.country, province: @user.state, city: @user.city, postal_code: @user.zip)
    end # if/else for country

    ups = ActiveShipping::UPS.new(login: 'lizbayardelle', password: 'UPSpassw0rd', key: '3D287D7B39D0D398')
    ups_response = ups.find_rates(origin, destination, packages)
    @ups_rates = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    usps = ActiveShipping::USPS.new(login: '380LINCH6422')
    usps_response = usps.find_rates(origin, destination, packages)
    @usps_rates = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

  def update_order
    @order = current_order
    if @order.update_order_from_shipping_page(params[:order][:shipping])
      redirect_to new_charge_path and return
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = "Something is amuck."
    end
  end

  def new
    @order = current_order
  end

  def create
    # Amount in cents
    @amount = current_order.total * 100
    @user = current_user
    @order = current_order

    if @user.stripe_customer_id.present?
      customer = @user.stripe_customer_id
    else
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
      @user.update_attributes(stripe_customer_id: customer.id)
    end
    @order.update_attributes(order_status_id: 2)
    @order.update_attributes(date_placed: DateTime.now)
    OrderMailer.order_placed(@user, @order).deliver_now
    OrderMailer.new_order(@user, @order).deliver_now
    session[:order_id] = nil


    charge = Stripe::Charge.create(
      :customer    => @user.stripe_customer_id,
      :amount      => @amount.to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

  private

  def order_params
    params.permit(:subtotal, :tax, :shipping, :total, :order_status_id, :user_id, :date_placed, :shipping_choice, :stripeToken)
  end
end
