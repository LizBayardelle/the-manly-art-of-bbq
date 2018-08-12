class ProductsController < ApplicationController
  def index
    @products = Product.all
    @order_item = current_order.order_items.new
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.product_image.attach(params[:product][:product_image])
    @product.save
    flash[:notice] = "Your product has been created!"
    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to products_path
      flash[:notice] = "That product has been updated."
    else
      render :action => :edit
      flash[:alert] = "Something went terribly wrong there..."
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:alert] = "Poof! That product is no more."
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :active, :short_description, :weight, :box_length, :box_width, :box_depth, :product_image, :has_size, :size_options)
  end
end
